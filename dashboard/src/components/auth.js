import { useState } from "react";
import { Button, TextField, Box, Snackbar, Alert, Typography, useTheme, IconButton } from "@mui/material";
import { sha512 } from 'js-sha512';
import { collection, query, where, getDocs } from "firebase/firestore";
import { db } from "../config/firebase";
import SignUp from "./signUp";
import { ArrowBack } from "@mui/icons-material";

export const Auth = ({ onLoginSuccess }) => {
    const [username, setUsername] = useState("");
    const [password, setPassword] = useState("");
    const [openSnackbar, setOpenSnackbar] = useState(false);
    const [snackbarMessage, setSnackbarMessage] = useState("");
    const [snackbarSeverity, setSnackbarSeverity] = useState("success");
    const [isSignUp, setIsSignUp] = useState(false);
    const usersCollectionRef = collection(db, "users");
    const theme = useTheme();

    const handleCloseSnackbar = () => {
        setOpenSnackbar(false);
    };

    const signIn = async () => {
        const hashedPassword = sha512(password);
        try {
            const q = query(
                usersCollectionRef,
                where("username", "==", username),
                where("password", "==", hashedPassword)
            );
            const querySnapshot = await getDocs(q);
            console.log(querySnapshot);

            if (querySnapshot.empty) {
                setSnackbarMessage("Username or password is incorrect");
                setSnackbarSeverity("error");
                setOpenSnackbar(true);
            } else {
                let isTeacher = false;
                let teacherData = null;

                querySnapshot.forEach((doc) => {
                    const userData = doc.data();
                    console.log(doc.id, " => ", userData);
                    if (userData.ref && userData.ref.path.includes("teachers")) {
                        isTeacher = true;
                        teacherData = userData;
                    }
                });

                if (isTeacher) {
                    setSnackbarMessage("User signed in successfully");
                    setSnackbarSeverity("success");
                    setOpenSnackbar(true);
                    setTimeout(() => {
                        onLoginSuccess(teacherData);
                    }, 1000);
                } else {
                    setSnackbarMessage("User is not a teacher");
                    setSnackbarSeverity("error");
                    setOpenSnackbar(true);
                }
            }
        } catch (err) {
            setSnackbarMessage("Error during sign in: " + err.message);
            setSnackbarSeverity("error");
            setOpenSnackbar(true);
        }
    };

    return (
        <Box
            sx={{
                display: 'flex',
                flexDirection: 'column',
                justifyContent: 'center',
                alignItems: 'center',
                minHeight: '100vh',
            }}
        >
            <Box sx={{ display: 'flex', alignItems: 'center', mb: 4 }}>
                {isSignUp && (
                    <IconButton onClick={() => setIsSignUp(false)} sx={{ mr: 2 }}>
                        <ArrowBack />
                    </IconButton>
                )}
                <Typography variant="h4" sx={{ fontFamily: 'Lato, sans-serif' }}>
                    {isSignUp ? "Sign Up" : "Login"}
                </Typography>
            </Box>

            {isSignUp ? (
                <SignUp 
                    onSignUpSuccess={() => setIsSignUp(false)} 
                    onGoBack={() => setIsSignUp(false)} 
                />
            ) : (
                <Box
                    sx={{
                        display: 'flex',
                        flexDirection: 'column',
                        justifyContent: 'center',
                        alignItems: 'center',
                        gap: 2,
                        padding: 3,
                        borderRadius: 2,
                        boxShadow: 3,
                        width: '300px',
                    }}
                >
                    <TextField
                        label="Username"
                        variant="outlined"
                        placeholder="Username..."
                        fullWidth
                        onChange={(inputEvent) => setUsername(inputEvent.target.value)}
                    />
                    <TextField
                        label="Password"
                        variant="outlined"
                        placeholder="Password..."
                        type="password"
                        fullWidth
                        onChange={(inputEvent) => setPassword(inputEvent.target.value)}
                    />
                    <Button variant="contained" onClick={signIn} fullWidth>
                        Sign In
                    </Button>
                    <Button variant="contained" onClick={() => setIsSignUp(true)} fullWidth>
                        Sign Up
                    </Button>
                </Box>
            )}

            <Snackbar
                open={openSnackbar}
                autoHideDuration={6000}
                onClose={handleCloseSnackbar}
            >
                <Alert
                    onClose={handleCloseSnackbar}
                    severity={snackbarSeverity}
                    sx={{ width: '100%' }}
                >
                    {snackbarMessage}
                </Alert>
            </Snackbar>
        </Box>
    );
};

export default Auth;
