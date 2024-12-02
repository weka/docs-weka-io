# SageMaker HyperPod and WEKA Integrations

## Overview

Amazon SageMaker HyperPod provides purpose-built infrastructure for large-scale model training. It supports distributed machine learning (ML), large language models (LLMs), and foundation models (FMs).

HyperPod simplifies GPU cluster creation and management. It integrates natively with Slurm and Amazon EKS for advanced orchestration. This enhances resilience and reduces training times for foundation models.

With WEKA support for Amazon SageMaker HyperPod, customers can use WEKA’s zero-copy, zero-tuning architecture to optimize performance across key workflows. These include data loading, model training, checkpointing, verification, tuning, and dataset archiving.

Using WEKA as the storage layer for SageMaker HyperPod improves GPU utilization and accelerates training workflows. This reduces the wall-clock time required to complete tasks, enabling faster and more efficient large-scale model training.

SageMaker HyperPod supports Slurm and Amazon EKS as orchestration engines. The following guide focuses on integrating SageMaker HyperPod with WEKA using Slurm as the orchestration engine.
