{ config, pkgs, ... }:

{
    i18n.inputMethod = {
        # Available since NixOS 24.11
        enable = true;
        type = "fcitx5";
        fcitx5 = {
            waylandFrontend = true;

            addons = with pkgs; [
                fcitx5-gtk
                fcitx5-rime
            ];
            settings = {
                inputMethod = {
                    "Groups/0" = {
                        Name = "Default";
                        "Default Layout" = "us";
                        DefaultIM = "keyboard-us";
                    };
                    "Groups/0/Items/0".Name = "keyboard-us";
                    "Groups/0/Items/1".Name = "rime";
                    GroupOrder."0" = "Default";

                };
                globalOptions = {
                    Hotkey = {
                        EnumerateWithTriggerKeys = "True";
                        ActivateKeys = "";
                        DeactivateKeys = "";
                        AltTriggerKeys = "";
                        EnumerateForwardKeys = "";
                        EnumerateBackwardKeys = "";
                        EnumerateSkipFirst = "False";
                        EnumerateGroupForwardKeys = "";
                        EnumerateGroupBackwardKeys = "";
                        PrevPage = "";
                        NextPage = "";
                        PrevCandidate = "";
                        NextCandidate = "";
                        TogglePreedit = "";
                        ModifierOnlyKeyTimeout = 250;
                    };
                    "Hotkey/TriggerKeys"."0" = "Super+space";
                    Behavior = {
                        ActiveByDefault = "False";
                        resetStateWhenFocusIn = "No";
                        ShareInputState = "No";
                        PreeditEnabledByDefault = "True";
                        ShowInputMethodInformation = "True";
                        showInputMethodInformationWhenFocusIn = "False";
                        CompactInputMethodInformation = "True";
                        ShowFirstInputMethodInformation = "True";
                        DefaultPageSize = 5;
                        OverrideXkbOption = "False";
                        CustomXkbOption = "";
                        EnabledAddons = "";
                        DisabledAddons = "";
                        PreloadInputMethod = "True";
                        AllowInputMethodForPassword = "False";
                        ShowPreeditForPassword = "False";
                        AutoSavePeriod = 30;

                    };
                };
            };
        };
    };
}
