#!/bin/bash

# Setup script for GitHub Pages branch
# This script helps set up the gh-pages branch with the initial README

echo "Setting up GitHub Pages branch..."

# Create and checkout gh-pages branch
git checkout -b gh-pages

# Copy the README for gh-pages
cp gh-pages-readme.md README.md

# Add and commit the README
git add README.md
git commit -m "Add initial README for GitHub Pages"

# Push the gh-pages branch
git push origin gh-pages

echo "GitHub Pages branch setup complete!"
echo "Don't forget to:"
echo "1. Go to your repository Settings"
echo "2. Scroll down to 'Pages' section"
echo "3. Set Source to 'Deploy from a branch'"
echo "4. Select 'gh-pages' branch and '/ (root)' folder"
echo "5. Save the settings"
echo ""
echo "Your Helm chart repository will be available at:"
echo "https://kairoscloud.github.io/kairoscloud-charts"
