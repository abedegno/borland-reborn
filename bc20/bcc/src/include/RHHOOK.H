#ifndef HEAP_HOOK_CALLSITE_VIEW_PROPOSAL_H
#define HEAP_HOOK_CALLSITE_VIEW_PROPOSAL_H
/* Unowned invocation view of the runtime slot at programDS:5EA8.
   This describes the CALLER'S physical protocol, not the C declaration of
   the installed callback: push domain then status, no caller argument pop.
   A handler that returns normally must restore the pre-argument stack.
   The known installed CDECL handler instead terminates/unwinds nonlocally.
   Keep its actual CDECL declaration unchanged; no compatible ordinary
   returning function-pointer conversion is claimed by this target-C view. */
typedef void (far pascal *HeapHookCallsite)(unsigned int domain,
                                         unsigned int status);
/* Proposed neutral unowned identity only. A future control must infer
   DS:5EA8 from the original operand and reconcile storage/installer views.
   No object is defined or initialized by this declaration. */
extern HeapHookCallsite HEAP_HOOK_CALLSITE;
#endif
