# filters/merge.jq
# Usage: jq -s -f filters/merge.jq --arg role "devops" companies/*.json skills/_common.json skills/devops.json

# The input is a stream of JSON objects (companies and skills).
# We need to separate them and construct the final object.

# 1. Collect all inputs into an array
# 1. Separate base (devops.resume.json) from other inputs
.[0] as $base |
.[1:] as $others |

# 2. Construct the final object
$base + {
  work: (
    $others
    | map(select(type == "object" and has("company") and (.hidden | not)))
    | sort_by(.startDate)
    | reverse
    | map({
        company: .company,
        website: .website,
        startDate: .startDate,
        endDate: .endDate,
        position: .descriptions[$role].position,
        business: .descriptions[$role].business,
        address: .descriptions[$role].address,
        summary: .descriptions[$role].summary,
        highlights: .descriptions[$role].highlights,
        projects: .descriptions[$role].projects
      })
  ),
  skills: (
    $others
    | map(select(type == "object" and has("skills")))
    | map(.skills)
    | flatten
  )
}
