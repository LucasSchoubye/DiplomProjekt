import React from 'react';
import PropTypes from 'prop-types';
import { Box, Typography, List, ListItem, ListItemText, Divider, useTheme, useMediaQuery } from '@mui/material';

const SubjectsList = ({ subjects, selectedClass }) => {
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

    return (
        <Box sx={{ width: getWidth(), maxWidth: '100%'}}>
            <Typography variant="h6" mb={2}>Subjects in {selectedClass.className}</Typography>
            <Divider />
            <List>
                {subjects.map((subject, index) => (
                    <React.Fragment key={subject.id}>
                        <ListItem>
                            <ListItemText primary={subject.id} />
                        </ListItem>
                        {index < subjects.length - 1 && <Divider />}
                    </React.Fragment>
                ))}
            </List>
        </Box>
    );
};

SubjectsList.propTypes = {
    subjects: PropTypes.arrayOf(PropTypes.shape({
        id: PropTypes.string.isRequired,
    })).isRequired,
    selectedClass: PropTypes.object.isRequired,
};

export default SubjectsList;
