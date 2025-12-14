# Chara AI/ML Library
# Simple machine learning and AI utilities for Chara
#
# Usage:
#   import ai
#   set model = call ai.linear_regression()
#   call ai.fit(model, x_data, y_data)
#   set prediction = call ai.predict(model, [5])

import math
import json

# Create a linear regression model
func linear_regression() {
    return {
        "type": "linear",
        "slope": 0,
        "intercept": 0,
        "trained": false
    }
}

# Fit linear regression model
# Simple least squares implementation
func fit(model, x, y) {
    set n = len(x)
    
    # Calculate means
    set sum_x = 0
    set sum_y = 0
    for i in range(n) {
        set sum_x = sum_x + x[i]
        set sum_y = sum_y + y[i]
    }
    set mean_x = sum_x / n
    set mean_y = sum_y / n
    
    # Calculate slope
    set numerator = 0
    set denominator = 0
    for i in range(n) {
        set dx = x[i] - mean_x
        set dy = y[i] - mean_y
        set numerator = numerator + dx * dy
        set denominator = denominator + dx * dx
    }
    
    set model["slope"] = numerator / denominator
    set model["intercept"] = mean_y - model["slope"] * mean_x
    set model["trained"] = true
    
    print format("📈 Model trained: y = {}x + {}", model["slope"], model["intercept"])
    return model
}

# Predict using trained model
func predict(model, x_values) {
    set predictions = []
    for x in x_values {
        set y = model["slope"] * x + model["intercept"]
        call push(predictions, y)
    }
    return predictions
}

# Calculate accuracy (R² score)
func score(model, x, y_true) {
    set y_pred = call predict(model, x)
    
    # Calculate mean of y
    set sum_y = 0
    for val in y_true {
        set sum_y = sum_y + val
    }
    set mean_y = sum_y / len(y_true)
    
    # Calculate SS_res and SS_tot
    set ss_res = 0
    set ss_tot = 0
    for i in range(len(y_true)) {
        set res = y_true[i] - y_pred[i]
        set tot = y_true[i] - mean_y
        set ss_res = ss_res + res * res
        set ss_tot = ss_tot + tot * tot
    }
    
    return 1 - (ss_res / ss_tot)
}

# K-Nearest Neighbors classifier (simple)
func knn(k) {
    return {
        "type": "knn",
        "k": k,
        "data": [],
        "labels": []
    }
}

# Fit KNN
func knn_fit(model, data, labels) {
    set model["data"] = data
    set model["labels"] = labels
    print format("🔍 KNN trained with {} samples", len(data))
}

# Predict with KNN (single point, 1D)
func knn_predict(model, point) {
    # Calculate distances
    set distances = []
    for i in range(len(model["data"])) {
        set dist = call math.abs(model["data"][i] - point)
        call push(distances, {"dist": dist, "label": model["labels"][i]})
    }
    
    # Sort by distance (simplified - just find k smallest)
    # Count labels in k nearest
    set votes = {}
    for i in range(model["k"]) {
        set min_idx = 0
        set min_dist = 999999
        for j in range(len(distances)) {
            if distances[j]["dist"] < min_dist {
                set min_dist = distances[j]["dist"]
                set min_idx = j
            }
        }
        set label = distances[min_idx]["label"]
        if votes[label] == null { set votes[label] = 0 }
        set votes[label] = votes[label] + 1
        set distances[min_idx]["dist"] = 999999  # Mark as used
    }
    
    # Return most common label
    set best_label = null
    set best_count = 0
    for label in votes {
        if votes[label] > best_count {
            set best_count = votes[label]
            set best_label = label
        }
    }
    
    return best_label
}

# Normalize data (0-1 range)
func normalize(values) {
    set min_val = values[0]
    set max_val = values[0]
    for v in values {
        if v < min_val { set min_val = v }
        if v > max_val { set max_val = v }
    }
    
    set result = []
    set range = max_val - min_val
    for v in values {
        call push(result, (v - min_val) / range)
    }
    return result
}

# Split data into train/test
func train_test_split(data, labels, test_ratio) {
    set n = len(data)
    set test_size = call math.floor(n * test_ratio)
    set train_size = n - test_size
    
    set train_data = []
    set train_labels = []
    set test_data = []
    set test_labels = []
    
    for i in range(train_size) {
        call push(train_data, data[i])
        call push(train_labels, labels[i])
    }
    for i in range(train_size, n) {
        call push(test_data, data[i])
        call push(test_labels, labels[i])
    }
    
    return {
        "train_data": train_data,
        "train_labels": train_labels,
        "test_data": test_data,
        "test_labels": test_labels
    }
}

# Sigmoid function
func sigmoid(x) {
    return 1 / (1 + call math.exp(-x))
}

# ReLU activation
func relu(x) {
    return x > 0 ? x : 0
}

# Save model to file
func save_model(model, filepath) {
    set jstr = json.stringify
    set content = call jstr(model)
    call io.writeFile(filepath, content)
    print format("💾 Model saved to {}", filepath)
}

# Load model from file
func load_model(filepath) {
    set content = call io.readFile(filepath)
    set jparse = json.parse
    return call jparse(content)
}

# Demo
func demo() {
    print "🤖 Chara AI Demo - Linear Regression"
    print ""
    
    # Training data: y = 2x + 1
    set x = [1, 2, 3, 4, 5]
    set y = [3, 5, 7, 9, 11]
    
    set model = call linear_regression()
    call fit(model, x, y)
    
    set predictions = call predict(model, [6, 7, 8])
    print format("Predictions for [6,7,8]: {}", predictions)
    
    set r2 = call score(model, x, y)
    print format("R² Score: {}", r2)
}
