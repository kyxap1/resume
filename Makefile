.PHONY: all clean devops devsecops

# Default target
all: devops

# Build for DevOps specialization
# Build for DevOps specialization
devops:
	@echo "Building DevOps resume..."
	@mkdir -p html
	jq -s -f filters/merge.jq --arg role "devops" devops.resume.json companies/*.json skills/_common.json skills/sre.json skills/devops.json > html/resume.json
	python3 scripts/render_resume.py html/resume.json -o html/devops.html
	@echo "Done! Open html/devops.html"

# Build for DevSecOps specialization
devsecops:
	@echo "Building DevSecOps resume..."
	@mkdir -p html
	jq -s -f filters/merge.jq --arg role "devsecops" companies/*.json skills/_common.json skills/sre.json skills/devops.json skills/devsecops.json > html/resume.json
	python3 scripts/render_resume.py html/resume.json -o html/devsecops.html
	@echo "Done! Open html/devsecops.html"

# Clean build artifacts
clean:
	rm -rf html
