import { useState } from "react";
import { Button, TextField, Box, Snackbar, Alert, Typography, useTheme, IconButton } from "@mui/material";
import { signInWithEmailAndPassword } from "firebase/auth";
import { collection, query, where, getDocs } from "firebase/firestore";
import { db, auth } from "../config/firebase";
import SignUp from "./signUp";
import { ArrowBack } from "@mui/icons-material";

export const Auth = ({ onLoginSuccess }) => {
    const [email, setEmail] = useState("admin"); // Default email for testing
    const [password, setPassword] = useState("admin"); // Default password for testing
    const [openSnackbar, setOpenSnackbar] = useState(false);
    const [snackbarMessage, setSnackbarMessage] = useState("");
    const [snackbarSeverity, setSnackbarSeverity] = useState("success");
    const [isSignUp, setIsSignUp] = useState(false);
    const [loading, setLoading] = useState(false); // Loading state
    const theme = useTheme();

    const handleCloseSnackbar = () => {
        setOpenSnackbar(false);
    };

    const signIn = async () => {
        const actualEmail = email === "admin" ? "michaelmicromanager@gmail.com" : email;
        const actualPassword = password === "admin" ? "test123" : password;

        if (!actualEmail || !actualPassword) {
            setSnackbarMessage("Email and password are required");
            setSnackbarSeverity("error");
            setOpenSnackbar(true);
            return;
        }

        setLoading(true);
        try {
            // Firebase Authentication sign-in with email and password
            const userCredential = await signInWithEmailAndPassword(auth, actualEmail, actualPassword);
            const user = userCredential.user;
            // console.log(user);

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
                    setSnackbarMessage("User not found");
                    setSnackbarSeverity("error");
                    setOpenSnackbar(true);
                }
            }
        } catch (err) {
            let errorMessage = "Email or password is incorrect";
            if (err.code === 'auth/user-not-found') {
                errorMessage = "User not found";
            } else if (err.code === 'auth/wrong-password') {
                errorMessage = "Incorrect password";
            }
            setSnackbarMessage(errorMessage);
            setSnackbarSeverity("error");
            setOpenSnackbar(true);
        } finally {
            setLoading(false);
        }
    };

    const handleSignUpSuccess = (newEmail, newPassword) => {
        setEmail(newEmail);
        setPassword(newPassword);
        setIsSignUp(false);
    };

    return (
        <Box
            sx={{
                display: 'flex',
                flexDirection: 'column',
                justifyContent: 'center', // Center vertically
                alignItems: 'center',
                minHeight: '100vh',
            }}
        >
            <Box sx={{ display: 'flex', alignItems: 'center', mb: 4, width: '300px', position: 'relative' }}>
                {isSignUp && (
                    <IconButton onClick={() => setIsSignUp(false)} sx={{ position: 'absolute', left: 0 }}>
                        <ArrowBack />
                    </IconButton>
                )}
                <Typography variant="h4" sx={{ fontFamily: 'Lato, sans-serif', flexGrow: 1, textAlign: 'center' }}>
                    {isSignUp ? "Sign Up" : "Login"}
                </Typography>
            </Box>

            {isSignUp ? (
                <SignUp 
                    onSignUpSuccess={handleSignUpSuccess} // Use the new callback
                    onGoBack={() => setIsSignUp(false)} 
                />
            ) : (
                <Box
                    sx={{
                        display: 'flex',
                        flexDirection: 'column',
                        justifyContent: 'center', // Center vertically
                        alignItems: 'center',
                        gap: 2,
                        padding: 3,
                        borderRadius: 2,
                        boxShadow: 3,
                        width: '300px',
                        marginTop: '20px', // Add some margin to separate from the title
                    }}
                >
                    <TextField
                        label="Email"
                        variant="outlined"
                        placeholder="Email..."
                        fullWidth
                        onChange={(inputEvent) => setEmail(inputEvent.target.value)}
                        value={email}
                    />
                    <TextField
                        label="Password"
                        variant="outlined"
                        placeholder="Password..."
                        type="password"
                        fullWidth
                        onChange={(inputEvent) => setPassword(inputEvent.target.value)}
                        value={password}
                    />
                    <Button 
                        variant="contained" 
                        onClick={signIn} 
                        fullWidth 
                        disabled={loading} // Disable button when loading
                    >
                        {loading ? "Signing In..." : "Sign In"}
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
