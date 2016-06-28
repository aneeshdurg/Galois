#pragma once
#include "Galois/Runtime/Cuda/cuda_mtypes.h"

struct CUDA_Context;

struct CUDA_Context *get_CUDA_context(int id);
bool init_CUDA_context(struct CUDA_Context *ctx, int device);
void load_graph_CUDA(struct CUDA_Context *ctx, MarshalGraph &g);

void reset_CUDA_context(struct CUDA_Context *ctx);
unsigned int get_node_dist_current_cuda(struct CUDA_Context *ctx, unsigned LID);
void set_node_dist_current_cuda(struct CUDA_Context *ctx, unsigned LID, unsigned int v);
void add_node_dist_current_cuda(struct CUDA_Context *ctx, unsigned LID, unsigned int v);
void min_node_dist_current_cuda(struct CUDA_Context *ctx, unsigned LID, unsigned int v);
unsigned int get_node_dist_old_cuda(struct CUDA_Context *ctx, unsigned LID);
void set_node_dist_old_cuda(struct CUDA_Context *ctx, unsigned LID, unsigned int v);
void add_node_dist_old_cuda(struct CUDA_Context *ctx, unsigned LID, unsigned int v);
void min_node_dist_old_cuda(struct CUDA_Context *ctx, unsigned LID, unsigned int v);
void BFS_cuda(int & __retval, struct CUDA_Context *ctx);
void FirstItr_BFS_cuda(struct CUDA_Context *ctx);
void InitializeGraph_cuda(const unsigned int & local_infinity, unsigned int local_src_node, struct CUDA_Context *ctx);
