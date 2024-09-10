import React from 'react';
import { Drawer, Box, useTheme, useMediaQuery } from '@mui/material';

const DrawerLayout = ({ children }) => {
    const theme = useTheme();
    const isXsScreen = useMediaQuery(theme.breakpoints.only('xs'));
    const isSmScreen = useMediaQuery(theme.breakpoints.only('sm'));
    const isMdScreen = useMediaQuery(theme.breakpoints.only('md'));

    const getWidth = () => {
        if (isXsScreen) return '100%';
        if (isSmScreen) return '200px';
        if (isMdScreen) return '300px';
        return '400px'; // for lg and above
    };

    const drawerWidth = getWidth();

    if (isXsScreen || isSmScreen) {
        // For extra small and small screens, render content without a drawer
        return (
            <Box sx={{ width: '100%', padding: 2 }}>
                {children}
            </Box>
        );
    }

    return (
        <Drawer
            variant="permanent"
            anchor="left"
            sx={{
                width: drawerWidth,
                flexShrink: 0,
                '& .MuiDrawer-paper': {
                    width: drawerWidth,
                    boxSizing: 'border-box',
                },
            }}
        >
            <Box sx={{ width: '100%', padding: 0, display: 'flex', justifyContent: 'center' }}>
                {children}
            </Box>
        </Drawer>
    );
};

export default DrawerLayout;