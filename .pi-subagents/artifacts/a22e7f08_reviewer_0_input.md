# Task for reviewer

[Read from: /home/zhaolun/nixos/plan.md, /home/zhaolun/nixos/progress.md]

You are a "reviewer" focused on security, usability, and practical correctness. Audit the X60s NixOS configuration at /home/zhaolun/nixos/X60s/ for real-world issues.

Read ALL these files:
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

Focus on:
1. Security: hardcoded passwords, disabled security features, SSH misconfig, slock setup
2. Usability: broken shell aliases, confusing keybindings, UX dead ends
3. Battery/Power: incomplete TLP config (commented out but references present), power management gaps
4. Network: DNS conflicts, iwd + NM wifi backend interaction
5. Data loss risk: rm alias behavior (prints message but still dangerous), no backup strategy
6. Boot issues: GRUB on MBR device, no fallback, no recovery options
7. DWM config: conflicting keybindings, missing keybindings for common tasks
8. Display: missing packages for dwm/st patches to compile, font issues
9. General: any practical issue that would cause trouble in daily use

Categorize findings by severity: critical, high, medium, low.

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