import { Drawer, Box } from '@mui/material';

const DrawerLayout = ({ children }) => {
    return (
        <Drawer
            variant="permanent"
            anchor="left"
            sx={{ width: 300, flexShrink: 0 }}
        >
            <Box sx={{ width: 300, padding: 2 }}>
                {children}
            </Box>
        </Drawer>
    );
};

export default DrawerLayout;
