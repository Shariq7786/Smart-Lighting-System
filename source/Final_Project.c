//MultiFeature.cpp
#include <iostream>
#include <unordered_map>
#include <vector>
#include <string>
#include <functional>
#include <numeric>
#include <algorithm>
// Feature Store
class FeatureStore {
public:
    void addFeature(const std::string& featureName, std::function<double(const std::vector<double>&)> featureGenerator) {
        featureGenerators[featureName] = featureGenerator;
    }
    std::unordered_map<std::string, double> getFeatures(const std::vector<double>& dataPoint) const {
        std::unordered_map<std::string, double> features;
        for (const auto& generator : featureGenerators) {
            features[generator.first] = generator.second(dataPoint);
        }
        return features;
    }
    std::vector<std::unordered_map<std::string, double>> getBatchFeatures(const std::vector<std::vector<double>>& dataBatch) const {
        std::vector<std::unordered_map<std::string, double>> batchFeatures;
        for (const auto& dataPoint : dataBatch) {
            batchFeatures.push_back(getFeatures(dataPoint));
        }
        return batchFeatures;
    }
private:
    std::unordered_map<std::string, std::function<double(const std::vector<double>&)>> featureGenerators;
};
// Linear Regression Model
class LinearRegression {
public:
    LinearRegression(const std::vector<double>& coefficients, double intercept)
        : coefficients(coefficients), intercept(intercept) {}

    double predict(const std::unordered_map<std::string, double>& features) const {
        double result = intercept;
        for (const auto& feature : features) {
            auto it = featureIndexes.find(feature.first);
            if (it != featureIndexes.end()) {
                result += coefficients[it->second] * feature.second;
            }
        }
        return result;
    }
    std::vector<double> batchPredict(const std::vector<std::unordered_map<std::string, double>>& batchFeatures) const {
        std::vector<double> predictions;
        for (const auto& features : batchFeatures) {
            predictions.push_back(predict(features));
        }
        return predictions;
    }
    void setFeatureIndexes(const std::unordered_map<std::string, size_t>& indexes) {
        featureIndexes = indexes;
    }
private:
    std::vector<double> coefficients;
    double intercept;
    std::unordered_map<std::string, size_t> featureIndexes;
};
// Example feature generators
double sumFeature(const std::vector<double>& dataPoint) {
    return std::accumulate(dataPoint.begin(), dataPoint.end(), 0.0);
}
double meanFeature(const std::vector<double>& dataPoint) {
    return sumFeature(dataPoint) / dataPoint.size();
}
double maxFeature(const std::vector<double>& dataPoint) {
    return *std::max_element(dataPoint.begin(), dataPoint.end());
}
int main() {
    // Define data points
    std::vector<std::vector<double>> dataBatch = {
        {1.0, 2.0, 3.0},
        {2.0, 3.0, 4.0},
        {3.0, 4.0, 5.0},
        {4.0, 5.0, 6.0}
    };
    // Initialize feature store and add feature generators
    FeatureStore featureStore;
    featureStore.addFeature("sum", sumFeature);
    featureStore.addFeature("mean", meanFeature);
    featureStore.addFeature("max", maxFeature);
    // Get features for the data batch
    auto batchFeatures = featureStore.getBatchFeatures(dataBatch);
    // Define model coefficients and intercept
    std::vector<double> coefficients = { 0.5, 1.0, 1.5 };  // Example coefficients corresponding to sum, mean, max
    double intercept = 2.0;  // Example intercept
    // Initialize the model and set feature indexes
    LinearRegression model(coefficients, intercept);
    std::unordered_map<std::string, size_t> featureIndexes = { {"sum", 0}, {"mean", 1}, {"max", 2} };
    model.setFeatureIndexes(featureIndexes);
    // Perform batch predictions
    auto predictions = model.batchPredict(batchFeatures);
    // Output predictions
    std::cout << "Predictions:" << std::endl;
    for (size_t i = 0; i < predictions.size(); ++i) {
        std::cout << "Prediction " << i + 1 << ": " << predictions[i] << std::endl;
    }
    return 0;
}