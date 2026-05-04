#!/bin/bash

# Check if a directory path is provided
TARGET_DIR="${1:-.}"

if [ ! -d "$TARGET_DIR" ]; then
    echo "Error: Directory '$TARGET_DIR' does not exist."
    exit 1
fi

echo "Analyzing file system structure for: $TARGET_DIR"
echo "Please wait, scanning (Optimized Single-Pass)..."
echo "------------------------------------------------"

# 1 & 2. Single-Pass Scan for Files, Directories, and Depth
# We use 'find' to output type (%y) and depth (%d) exactly once.
# 'awk' processes this stream in RAM to tally everything instantly.
read total_files total_dirs max_depth <<< $(find "$TARGET_DIR" -mindepth 0 -printf '%y %d\n' 2>/dev/null | awk '
    $1 == "f" { files++ }
    $1 == "d" { 
        dirs++; 
        if ($2 > max_d) max_d = $2 
    }
    END { print files+0, dirs+0, max_d+0 }
')

# Calculate Total Items (Files + Directories)
total_items=$((total_dirs + total_files))

# 3. Perform Calculations (Using awk for floating point math)

# Formula 1.A: Average Breadth (Fan-out)
# B_avg = Total Items / Total Directories
if [ "$total_dirs" -gt 0 ]; then
    avg_breadth=$(awk "BEGIN {printf \"%.2f\", $total_items / $total_dirs}")
else
    avg_breadth="0"
fi

# Formula 1.C: Directory-to-File Ratio
# R_df = Total Directories / Total Files
if [ "$total_files" -gt 0 ]; then
    dir_file_ratio=$(awk "BEGIN {printf \"%.4f\", $total_dirs / $total_files}")
else
    dir_file_ratio="Infinite (No files)"
fi

# 4. Output Results

echo "### Raw Statistics"
echo "Total number of files exist in the input folder path: $total_files"
echo "Total Directories:                                    $total_dirs"
echo "Total Items (Files + Dirs):                           $total_items"
echo ""
echo "### Complexity Metrics"
echo "------------------------------------------------"
echo "1.A Average Breadth (Fan-out):  $avg_breadth"
echo "    (Formula: Items / Dirs)"
echo "    -> Interpretation: On average, each folder contains $avg_breadth items."
echo ""
echo "1.B Maximum Depth:              $max_depth levels"
echo "    (Formula: Longest path segment count)"
echo "    -> Interpretation: The deepest nesting level relative to start."
echo ""
echo "1.C Dir-to-File Ratio:          $dir_file_ratio"
echo "    (Formula: Dirs / Files)"
echo "    -> Interpretation: value > 0.5 implies deep/sparse nesting."
echo "                       value near 0 implies flat/dense structure."
echo "------------------------------------------------"

# 5. Generalization / Classification
echo "### Generalized Classification"
echo -n "Structure Type: "

# Simple logic to classify based on the metrics
# We use 'bc' for floating point comparison. If 'bc' is missing, it defaults to a basic check.
if command -v bc >/dev/null 2>&1; then
    if (( $(echo "$avg_breadth > 500" | bc -l) )); then
        echo "FLAT / PARKING LOT (High Breadth)"
    elif [ "$max_depth" -gt 10 ]; then
        echo "DEEP / SKYSCRAPER (High Depth)"
    elif (( $(echo "$dir_file_ratio > 0.5" | bc -l) )); then
        echo "SPARSE MESH (High Overhead)"
    else
        echo "BALANCED TREE"
    fi
else
    # Fallback if 'bc' is not installed
    echo "BALANCED TREE (Install 'bc' for precise classification)"
fi