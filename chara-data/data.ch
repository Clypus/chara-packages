# Chara Data Science Library
# Data analysis and visualization for Chara
#
# Usage:
#   import data
#   set df = call data.read_csv("data.csv")
#   set avg = call data.mean(df["column"])
#   call data.plot(df, "bar")

import csv
import io
import math
import string

# Read CSV file into a data structure
# Returns: {"headers": [...], "rows": [[...], ...], "columns": {...}}
func read_csv(filepath) {
    set csvread = csv.read
    set raw = call csvread(filepath)
    
    set headers = raw[0]
    set rows = []
    
    for i in range(1, len(raw)) {
        call push(rows, raw[i])
    }
    
    # Build column index
    set columns = {}
    for i in range(len(headers)) {
        set col_data = []
        for row in rows {
            call push(col_data, row[i])
        }
        set columns[headers[i]] = col_data
    }
    
    return {
        "headers": headers,
        "rows": rows,
        "columns": columns
    }
}

# Get column data
func col(df, name) {
    return df["columns"][name]
}

# Calculate mean (average)
func mean(values) {
    set total = 0
    for v in values {
        set total = total + v
    }
    return total / len(values)
}

# Calculate sum
func sum(values) {
    set total = 0
    for v in values {
        set total = total + v
    }
    return total
}

# Calculate min
func min(values) {
    set result = values[0]
    for v in values {
        if v < result {
            set result = v
        }
    }
    return result
}

# Calculate max  
func max(values) {
    set result = values[0]
    for v in values {
        if v > result {
            set result = v
        }
    }
    return result
}

# Calculate standard deviation
func std(values) {
    set avg = call mean(values)
    set variance = 0
    for v in values {
        set diff = v - avg
        set variance = variance + diff * diff
    }
    set variance = variance / len(values)
    return call math.sqrt(variance)
}

# Count values
func count(values) {
    return len(values)
}

# Filter rows where condition is true
# filter(df, column, operator, value)
func filter(df, column, op, value) {
    set result_rows = []
    set col_idx = 0
    
    for i in range(len(df["headers"])) {
        if df["headers"][i] == column {
            set col_idx = i
        }
    }
    
    for row in df["rows"] {
        set cell = row[col_idx]
        set match = false
        
        if op == "==" { set match = cell == value }
        if op == "!=" { set match = cell != value }
        if op == ">" { set match = cell > value }
        if op == "<" { set match = cell < value }
        if op == ">=" { set match = cell >= value }
        if op == "<=" { set match = cell <= value }
        
        if match {
            call push(result_rows, row)
        }
    }
    
    return {
        "headers": df["headers"],
        "rows": result_rows,
        "columns": {}
    }
}

# Simple ASCII bar chart
func plot(values, chart_type) {
    if chart_type == "bar" {
        set max_val = call max(values)
        print ""
        for i in range(len(values)) {
            set v = values[i]
            set bar_len = (v * 40) / max_val
            set bar = call string.repeat("█", bar_len)
            print format("{:3} | {} {}", i, bar, v)
        }
        print ""
    }
    
    if chart_type == "line" {
        set max_val = call max(values)
        print ""
        for row in range(10, 0, -1) {
            set threshold = (row * max_val) / 10
            set line = ""
            for v in values {
                if v >= threshold {
                    set line = line + "●"
                } else {
                    set line = line + " "
                }
            }
            print format("{:5} │{}", threshold, line)
        }
        print "      └" + call string.repeat("─", len(values))
        print ""
    }
}

# Describe dataset
func describe(df) {
    print ""
    print "📊 Dataset Description"
    print format("   Rows: {}", len(df["rows"]))
    print format("   Columns: {}", len(df["headers"]))
    print ""
    print "   Columns:"
    for h in df["headers"] {
        print format("     - {}", h)
    }
    print ""
}

# Group by column and aggregate
func groupby(df, column, agg_col, agg_func) {
    set groups = {}
    set col_idx = 0
    set agg_idx = 0
    
    # Find column indices
    for i in range(len(df["headers"])) {
        if df["headers"][i] == column { set col_idx = i }
        if df["headers"][i] == agg_col { set agg_idx = i }
    }
    
    # Group values
    for row in df["rows"] {
        set key = row[col_idx]
        set val = row[agg_idx]
        
        if groups[key] == null {
            set groups[key] = []
        }
        call push(groups[key], val)
    }
    
    # Apply aggregation
    set result = {}
    for key in groups {
        if agg_func == "sum" { set result[key] = call sum(groups[key]) }
        if agg_func == "mean" { set result[key] = call mean(groups[key]) }
        if agg_func == "count" { set result[key] = call count(groups[key]) }
        if agg_func == "min" { set result[key] = call min(groups[key]) }
        if agg_func == "max" { set result[key] = call max(groups[key]) }
    }
    
    return result
}

# Demo
func demo() {
    print "📊 Chara Data Library Demo"
    print ""
    
    set values = [10, 25, 15, 30, 20, 35, 25]
    
    print format("Data: {}", values)
    print format("Mean: {}", call mean(values))
    print format("Sum: {}", call sum(values))
    print format("Min: {}", call min(values))
    print format("Max: {}", call max(values))
    
    print ""
    print "Bar Chart:"
    call plot(values, "bar")
}
