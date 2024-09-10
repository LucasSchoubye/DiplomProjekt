import React from 'react';
import { Box, Typography, List, ListItem, ListItemText, Divider, useTheme, useMediaQuery } from '@mui/material';

const ClassList = ({ classes, teacherName, handleClassClick }) => {
    const theme = useTheme();
    const isXsScreen = useMediaQuery(theme.breakpoints.only('xs'));
    const isSmScreen = useMediaQuery(theme.breakpoints.only('sm'));
    const isMdScreen = useMediaQuery(theme.breakpoints.only('md'));

    const getWidth = () => {
        if (isXsScreen) return '100%';
        if (isSmScreen) return '450px';
        if (isMdScreen) return '600px';
        return '750px'; // for lg and above
    };

    return (
        <Box sx={{ width: getWidth(), maxWidth: '100%', padding: 2, margin: 'auto' }}>
            <Typography variant="h4" gutterBottom>Welcome, {teacherName}</Typography>
            <Typography variant="h6" mb={2}>Your Classes</Typography>
            <Divider />
            <List>
                {classes.map((classData, index) => (
                    <React.Fragment key={classData.id}>
                        <ListItem button="true" onClick={() => handleClassClick(classData)}>
                            <ListItemText primary={classData.className} />
                        </ListItem>
                        {index < classes.length - 1 && <Divider />}
                    </React.Fragment>
                ))}
            </List>
        </Box>
    );
};

export default ClassList;