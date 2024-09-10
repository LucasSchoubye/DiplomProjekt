import { createTheme } from '@mui/material/styles';

const darkTheme = createTheme({
  palette: {
    mode: 'dark',
    // Define dark mode colors here
    primary: {
      main: '#90caf9',
    },
    secondary: {
      main: '#f48fb1',
    },
    background: {
      default: '#121212',
      paper: '#424242',
    },
    text: {
      primary: '#fff',
      secondary: '#bbb',
    },
  },
  typography: {
    // Define typography settings here
  },
});

export default darkTheme;
