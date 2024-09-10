import { Box, Typography, List, ListItem, ListItemText, Divider, Button, CircularProgress } from '@mui/material';

const StudentList = ({ students, selectedClass, handleBackClick, isLoading }) => {
    return (
        <Box sx={{ width: 300, padding: 2 }}>
            <Button variant="outlined" onClick={handleBackClick} fullWidth>Back</Button>
            <Typography variant="h6" mt={2}>
                Students in {selectedClass.className}
            </Typography>
            <Divider variant="middle" />
            <List>
                {isLoading ? (
                    <Box display="flex" justifyContent="center" alignItems="center" minHeight={100}>
                        <CircularProgress />
                    </Box>
                ) : students.length > 0 ? (
                    students.map((studentData, index) => (
                        <Box key={studentData.id}>
                            <ListItem button>
                                <ListItemText primary={studentData.fullName} />
                            </ListItem>
                            {index < students.length - 1 && <Divider />}
                        </Box>
                    ))
                ) : (
                    <Typography variant="body1">No students found</Typography>
                )}
            </List>
        </Box>
    );
};

export default StudentList;