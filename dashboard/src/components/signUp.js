import { useState } from "react";
import { TextField, Button, Box, Snackbar, Alert, Typography } from "@mui/material";
import { collection, query, where, getDocs, setDoc, doc } from "firebase/firestore";
import { createUserWithEmailAndPassword } from "firebase/auth";
import { db, auth } from "../config/firebase";

const passwordRequirements = [
    { label: "At least 8 characters", test: (password) => password.length >= 8 },
    { label: "At least one uppercase letter", test: (password) => /[A-Z]/.test(password) },
    { label: "At least one lowercase letter", test: (password) => /[a-z]/.test(password) },
    { label: "At least one number", test: (password) => /[0-9]/.test(password) },
    { label: "At least one special character", test: (password) => /[!@#$%^&*]/.test(password) },
];

const SignUp = ({ onSignUpSuccess, onGoBack }) => {
    const [email, setEmail] = useState("");
    const [username, setUsername] = useState("");
    const [password, setPassword] = useState("");
    const [confirmPassword, setConfirmPassword] = useState("");
    const [openSnackbar, setOpenSnackbar] = useState(false);
    const [snackbarMessage, setSnackbarMessage] = useState("");
    const [snackbarSeverity, setSnackbarSeverity] = useState("success");
    const [passwordValidations, setPasswordValidations] = useState(passwordRequirements.map(() => false));
    const usersCollectionRef = collection(db, "users");

    const handleCloseSnackbar = () => {
        setOpenSnackbar(false);
    };

    const handlePasswordChange = (inputEvent) => {
        const newPassword = inputEvent.target.value;
        setPassword(newPassword);
        setPasswordValidations(passwordRequirements.map(req => req.test(newPassword)));
    };

    const signUp = async () => {
        if (password !== confirmPassword) {
            setSnackbarMessage("Passwords do not match");
            setSnackbarSeverity("error");
            setOpenSnackbar(true);
            return;
        }

        if (!passwordValidations.every(Boolean)) {
            setSnackbarMessage("Password does not meet all requirements");
            setSnackbarSeverity("error");
            setOpenSnackbar(true);
            return;
        }

        try {
            const q = query(usersCollectionRef, where("username", "==", username));
            const querySnapshot = await getDocs(q);

            if (!querySnapshot.empty) {
                setSnackbarMessage("The username is taken");
                setSnackbarSeverity("error");
                setOpenSnackbar(true);
                return;
            }

            // Firebase Authentication sign-up with email and password
            const userCredential = await createUserWithEmailAndPassword(auth, email, password);
            const user = userCredential.user;

            await setDoc(doc(usersCollectionRef, user.uid), {
                username: username,
                userID: user.uid
            });

            setSnackbarMessage("User signed up successfully");
            setSnackbarSeverity("success");
            setOpenSnackbar(true);
            
            setTimeout(() => {
                onSignUpSuccess(email, password); // Pass email and password
            }, 1000); // 1 second delay
        } catch (err) {
            let errorMessage = "Error during sign up: " + err.message;
            if (err.code === 'auth/email-already-in-use') {
                errorMessage = "The email address is already in use";
            } else if (err.code === 'auth/invalid-email') {
                errorMessage = "The email address is not valid";
            } else if (err.code === 'auth/weak-password') {
                errorMessage = "The password is too weak";
            }
            setSnackbarMessage(errorMessage);
            setSnackbarSeverity("error");
            setOpenSnackbar(true);
        }
    };

    return (
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
                value={email} // Add this line
                onChange={(inputEvent) => setEmail(inputEvent.target.value)}
            />
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
                onChange={handlePasswordChange}
            />
            <Box sx={{ width: '100%' }}>
                {passwordRequirements.map((req, index) => (
                    !passwordValidations[index] && (
                        <Typography
                            key={index}
                            variant="body2"
                            color="red"
                        >
                            {req.label}
                        </Typography>
                    )
                ))}
            </Box>
            <TextField
                label="Confirm Password"
                variant="outlined"
                placeholder="Confirm Password..."
                type="password"
                fullWidth
                onChange={(inputEvent) => setConfirmPassword(inputEvent.target.value)}
            />
            <Button variant="contained" onClick={signUp} fullWidth>
                Sign Up
            </Button>

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

export default SignUp;