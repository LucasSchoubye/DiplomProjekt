import { Box, Typography, List, ListItem, ListItemText, Divider } from '@mui/material';

const ClassList = ({ classes, teacherName, handleClassClick }) => {
    return (
        <Box sx={{ width: 300, padding: 2 }}>
            <Typography variant="h4" gutterBottom>Welcome, {teacherName}</Typography>
            <Typography variant="h6">Your Classes</Typography>
            <Divider variant="middle" />
            <List>
                {classes.map((classData, index) => (
                    <Box key={classData.id}>
                        <ListItem button onClick={() => handleClassClick(classData)}>
                            <ListItemText primary={classData.className} />
                        </ListItem>
                        {index < classes.length - 1 && <Divider />}
                    </Box>
                ))}
            </List>
        </Box>
    );
};

export default ClassList;
