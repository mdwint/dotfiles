export const command = `osascript -e '
global frontApp, frontAppName, windowTitle

set windowTitle to ""
tell application "System Events"
    set frontApp to first application process whose frontmost is true
    set frontAppName to name of frontApp
    tell process frontAppName
        tell (1st window whose value of attribute "AXMain" is true)
            set windowTitle to value of attribute "AXTitle"
        end tell
    end tell
end tell

return {windowTitle}
'`;
export const refreshFrequency = 100;

export const className = `
  left: 8px;
  top: 12px;

  font-family: 'PragmataPro Mono';
  font-size: 16;
  color: white;
`;

export const render = ({ output }) => {
  return <div>{output}</div>;
};
