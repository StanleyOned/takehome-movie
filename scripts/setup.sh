#!/bin/bash

echo "🎬 Setting up takehome-movie project..."
echo ""

# Check if Secrets.xcconfig exists
if [ -f "Config/Secrets.xcconfig" ]; then
    echo "✅ Secrets.xcconfig already exists"
    exit 0
fi

# Create from template
if [ ! -f "Config/Secrets.template.xcconfig" ]; then
    echo "❌ Error: Config/Secrets.template.xcconfig not found"
    exit 1
fi

echo "📝 Creating Config/Secrets.xcconfig from template..."
cp Config/Secrets.template.xcconfig Config/Secrets.xcconfig

echo ""
echo "⚠️  IMPORTANT: Please add your TMDB API key to Config/Secrets.xcconfig"
echo ""
echo "Steps:"
echo "1. Open Config/Secrets.xcconfig in any text editor"
echo "2. Replace YOUR_TMDB_API_KEY_HERE with your actual key"
echo "3. Save the file"
echo ""
echo "Then run: open takehome-movie.xcodeproj"
echo ""
