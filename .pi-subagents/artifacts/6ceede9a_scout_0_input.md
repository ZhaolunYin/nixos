# Task for scout

You are a "scout" reviewer. Thoroughly audit the X60s NixOS configuration at /home/zhaolun/nixos/X60s/ for any and all bugs, issues, inconsistencies, and potential problems.

Read ALL these files completely:
- /home/zhaolun/nixos/X60s/hardware-configuration.nix
- /home/zhaolun/nixos/X60s/modules/nixos/core.nix
- /home/zhaolun/nixos/X60s/modules/nixos/boot.nix
- /home/zhaolun/nixos/X60s/modules/nixos/display.nix
- /home/zhaolun/nixos/X60s/modules/nixos/locale.nix
- /home/zhaolun/nixos/X60s/modules/nixos/network.nix
- /home/zhaolun/nixos/X60s/modules/nixos/sound.nix
- /home/zhaolun/nixos/X60s/modules/nixos/packages.nix
- /home/zhaolun/nixos/X60s/modules/nixos/ssh.nix
- /home/zhaolun/nixos/X60s/modules/nixos/garbage.nix
- /home/zhaolun/nixos/X60s/battery.nix
- /home/zhaolun/nixos/X60s/users.nix
- /home/zhaolun/nixos/X60s/modules/_home/default.nix
- /home/zhaolun/nixos/X60s/modules/_home/profile.nix
- /home/zhaolun/nixos/X60s/modules/_home/shell.nix
- /home/zhaolun/nixos/X60s/modules/_home/git.nix
- /home/zhaolun/nixos/X60s/modules/_home/neovim.nix
- /home/zhaolun/nixos/X60s/modules/_home/gnupg.nix
- /home/zhaolun/nixos/X60s/modules/_home/packages.nix
- /home/zhaolun/nixos/X60s/modules/_home/wallpaper.nix
- /home/zhaolun/nixos/X60s/modules/nixos/patches/dwm.h
- /home/zhaolun/nixos/X60s/modules/nixos/patches/slstatus.h
- /home/zhaolun/nixos/flake.nix

Look for:
1. Syntax/type errors in Nix expressions
2. Missing or inconsistent imports
3. Dead code, unused variables
4. Conflicting settings across files
5. Shell script bugs (e.g. in .xinitrc, zsh initExtra)
6. C code issues in patches (dwm.h, slstatus.h)
7. Security issues
8. Usability problems
9. Broken references (e.g. missing files, wrong paths)
10. Anything else that looks wrong

Be thorough and systematic. Report every finding with file path, line context, severity, and explanation.

---
**Output:**
Write your findings to exactly this path: /home/zhaolun/nixos/.pi-subagents/artifacts/outputs/6ceede9a/context.md
This path is authoritative for this run.
Ignore any other output filename or output path mentioned elsewhere, including output destinations in the base agent prompt, system prompt, or task instructions.

## Acceptance Contract
Acceptance level: attested
Completion is not accepted from prose alone. End with a structured acceptance report.

Criteria:
- criterion-1: Return concrete findings with file paths and severity when applicable

Required evidence: review-findings, residual-risks

Finish with a fenced JSON block tagged `acceptance-report` in this shape:
Use empty arrays when no items apply; array fields contain strings unless object entries are shown.
`criteriaSatisfied[].status` must be exactly one of: satisfied, not-satisfied, not-applicable.
`commandsRun[].result` must be exactly one of: passed, failed, not-run.
`manualNotes` and `notes` are optional strings; an empty string means no note and does not satisfy `manual-notes` evidence.
```acceptance-report
{
  "criteriaSatisfied": [
    {
      "id": "criterion-1",
      "status": "satisfied",
      "evidence": "specific proof"
    }
  ],
  "changedFiles": [
    "src/file.ts"
  ],
  "testsAddedOrUpdated": [
    "test/file.test.ts"
  ],
  "commandsRun": [
    {
      "command": "command",
      "result": "passed",
      "summary": "short result"
    }
  ],
  "validationOutput": [
    "validation output or concise summary"
  ],
  "residualRisks": [
    "none"
  ],
  "noStagedFiles": true,
  "diffSummary": "short description of the diff",
  "reviewFindings": [
    "blocker: file.ts:12 - issue found, or no blockers"
  ],
  "manualNotes": "anything else the parent should know"
}
```