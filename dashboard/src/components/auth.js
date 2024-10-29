import { useState } from "react";
import { Button, TextField, Box, Snackbar, Alert, Typography, useTheme, IconButton } from "@mui/material";
import { signInWithEmailAndPassword } from "firebase/auth";
import { collection, query, where, getDocs } from "firebase/firestore";
import { db, auth } from "../config/firebase";
import SignUp from "./signUp";
import { ArrowBack } from "@mui/icons-material";

export const Auth = ({ onLoginSuccess }) => {
    const [email, setEmail] = useState("");
    const [password, setPassword] = useState("");
    const [openSnackbar, setOpenSnackbar] = useState(false);
    const [snackbarMessage, setSnackbarMessage] = useState("");
    const [snackbarSeverity, setSnackbarSeverity] = useState("success");
    const [isSignUp, setIsSignUp] = useState(false);
    const theme = useTheme();

    const handleCloseSnackbar = () => {
        setOpenSnackbar(false);
    };

    const signIn = async () => {
        try {
            // Firebase Authentication sign-in with email and password
            const userCredential = await signInWithEmailAndPassword(auth, email, password);
            const user = userCredential.user;

            if (user) {
                // Query Firestore for the user document based on the authenticated user's UID
                const usersCollectionRef = collection(db, "users");
                const q = query(usersCollectionRef, where("userID", "==", user.uid));
                const querySnapshot = await getDocs(q);

                if (!querySnapshot.empty) {
                    const userData = querySnapshot.docs[0].data();
                    setSnackbarMessage("User signed in successfully");
                    setSnackbarSeverity("success");
                    setOpenSnackbar(true);
                    setTimeout(() => {
                        onLoginSuccess(userData);
                    }, 1000);
                } else {
                    setSnackbarMessage("Email or password is incorrect");
                    setSnackbarSeverity("error");
                    setOpenSnackbar(true);
                }
            }
        } catch (err) {
            setSnackbarMessage("Email or password is incorrect");
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
                        label="Email"
                        variant="outlined"
                        placeholder="Email..."
                        fullWidth
                        onChange={(inputEvent) => setEmail(inputEvent.target.value)}
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
