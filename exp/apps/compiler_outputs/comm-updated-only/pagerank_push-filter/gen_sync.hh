#include "Galois/Runtime/sync_structures.h"

GALOIS_SYNC_STRUCTURE_REDUCE_ADD(nout, unsigned int);
GALOIS_SYNC_STRUCTURE_BROADCAST(nout, unsigned int);
GALOIS_SYNC_STRUCTURE_BITSET(nout);

GALOIS_SYNC_STRUCTURE_REDUCE_ADD(residual, float);
GALOIS_SYNC_STRUCTURE_BROADCAST(residual, float);
GALOIS_SYNC_STRUCTURE_BITSET(residual);
