import { useState } from "react";
import { Button, TextField, Box, Snackbar, Alert, Typography, useTheme } from "@mui/material";
import { sha1 } from 'js-sha1';
import { collection, query, where, getDocs, setDoc, doc } from "firebase/firestore"; // Import Firestore functions
import { db } from "../config/firebase"; // Import your Firestore database

export const Auth = ({ onLoginSuccess }) => {
    const [username, setUsername] = useState("");
    const [password, setPassword] = useState("");
    const [openSnackbar, setOpenSnackbar] = useState(false);
    const [snackbarMessage, setSnackbarMessage] = useState("");
    const [snackbarSeverity, setSnackbarSeverity] = useState("success");
    const usersCollectionRef = collection(db,"users");
    const theme = useTheme();

    const handleCloseSnackbar = () => {
        setOpenSnackbar(false);
    };

    const signIn = async () => {
        const hashedPassword = sha1(password);
        try {
            const q = query(
                usersCollectionRef,
                where("username", "==", username),
                where("password", "==", hashedPassword)
            );
            const querySnapshot = await getDocs(q);

            if (querySnapshot.empty) {
                setSnackbarMessage("Username or password is incorrect");
                setSnackbarSeverity("error");
                setOpenSnackbar(true);
            } else {
                setSnackbarMessage("User signed in successfully");
                setSnackbarSeverity("success");
                setOpenSnackbar(true);
                onLoginSuccess();
                querySnapshot.forEach((doc) => {
                    console.log(doc.id, " => ", doc.data());
                });
            }
        } catch (err) {
            setSnackbarMessage("Error during sign in: " + err.message);
            setSnackbarSeverity("error");
            setOpenSnackbar(true);
        }
    };

    const signUp = async () => {
        const hashedPassword = sha1(password);
        try {
            await setDoc(doc(usersCollectionRef), {
                username: username,
                password: hashedPassword
            });
            setSnackbarMessage("User signed up successfully");
            setSnackbarSeverity("success");
            setOpenSnackbar(true);
        } catch (err) {
            setSnackbarMessage("Error during sign up: " + err.message);
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
            <Typography variant="h4" sx={{ mb: 4, fontFamily: 'Lato, sans-serif'  }}>
                Login
            </Typography>

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
                <Button variant="contained" onClick={signUp} fullWidth>
                    Sign Up
                </Button>
            </Box>

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