#!/bin/bash

set -e

CHART_DIR="nodebb-tenant-chart"
CHART_PACKAGE_OUTPUT="."

# Package the Helm chart
echo "📦 Packaging Helm chart..."
helm package "$CHART_DIR" -d "$CHART_PACKAGE_OUTPUT"

# Update the Helm repo index
echo "🔄 Updating Helm repo index..."
helm repo index "$CHART_PACKAGE_OUTPUT" --url https://pjanprinsloo.github.io/nodebb-helm/

# Stage changes
echo "📂 Staging files..."
git add .

# Commit with timestamp or custom message
COMMIT_MSG=${1:-"chart update $(date +'%Y-%m-%d %H:%M:%S')"}
echo "✅ Committing: $COMMIT_MSG"
git commit -m "$COMMIT_MSG"

# Push to GitHub
echo "🚀 Pushing to GitHub..."
git push

echo "✅ Done!"
