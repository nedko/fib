/* -*- Mode: C ; c-basic-offset: 2 -*- */

#include <stdint.h>
#include <stdio.h>
#include <sched.h>
#include <stdbool.h>

typedef uint32_t natint;

#if 1
bool disable_preemption()
{
  struct sched_param sched_param;

  sched_param.sched_priority = 10;
  if (sched_setscheduler(0, SCHED_FIFO, &sched_param) != 0)
  {
    perror("Cannot set scheduling policy");
    return false;
  }

  return true;
}
#endif

int main()
{
  natint n, n1, n2;
  uint32_t i;

  disable_preemption();

  n2 = 0;
  n1 = 1;
  i = 0;
  while (i++ < UINT32_MAX)
  {
    n = n1 + n2;
    n2 = n1;
    n1 = n;
  }

  //printf("0x%llX\n", (unsigned long long)n);

  return ~n & 1;                 /* disable optimization */
}
