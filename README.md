# EEG_Classification
# Computational Intelligence Project - Readme

This repository contains the code and documentation for the Computational Intelligence project conducted by Mohammad Hossein Shafizadegan (99104781). The project was supervised by Dr. S. Hajipour.

## Project Overview

The aim of this project was to predict the sentiment of video stimuli played through VR headsets using EEG recordings. The provided dataset consisted of recordings from 59 electrodes, sampled at a rate of 1 kHz. The data was epoched into 1 second pre-stimulus and 4 seconds post-stimulus segments, resulting in a total of 550 trials.

To achieve the prediction task, two types of neural networks were trained: MLP (Multi-Layer Perceptron) and RBF (Radial Basis Function). The key steps involved in the project were feature extraction, feature selection, and model training. The following sections provide a brief overview of each step.

## Feature Extraction

Feature extraction was divided into two main categories: statistical time domain features and frequency domain features.

### Statistical Time Domain Features

Various time domain features were extracted, including:

1. Variance: The variance of each channel for each trial was calculated using the function `calc_feature_var()`.
2. Amplitude Histogram: The histogram of amplitudes within a specified range and number of bins was computed for each trial and channel.
3. AR Model Coefficients: Autoregressive (AR) model coefficients were calculated using the MATLAB function `ar()`.
4. Form Factor (FF): Form Factor, which represents the shape or pattern of signals, was computed using the formula provided.

### Frequency Domain Features

Different frequency domain features were extracted, including:

1. Maximum Frequency: The frequency with the highest amplitude in the FFT (Fast Fourier Transform) of each channel's signal was determined.
2. Average Frequency: The mean frequency of each channel's signal was calculated.
3. Median Frequency: The median frequency of each channel's signal was computed.
4. Different EEG band power

## Feature Selection

Two methods were employed for feature selection: One-dimensional Fisher score and bulky feature selection using J score. Additionally, Particle Swarm Optimization (PSO) was utilized to enhance the feature selection process.

## Model Training

The MLP and RBF neural networks were trained using the selected features. The hyperparameters of the models were tuned to achieve optimal performance.

## Results

The results of the project are presented, including the performance of feature selection using Fisher score, bulky feature selection using J score, and feature selection empowered by PSO.

## Limitations and Future Works

The limitations encountered during the project are discussed, and potential future works and improvements are suggested.

For more details on the implementation and code, please refer to the project files in this repository.

## Contact Information

For any inquiries or further information, please contact me:
- mh.shafizadegan@gmail.com