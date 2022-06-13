export const command = "date '+%a %d/%m %H:%M'";
export const refreshFrequency = 1000;

export const className = `
  right: 8px;
  top: 12px;

  font-family: 'Iosevka Term Light';
  font-size: 16;
  color: white;
`;

export const render = ({ output }) => {
  return <div>{output}</div>;
};
