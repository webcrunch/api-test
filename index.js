// Port to run on
const port = 5000;

import express from "express";
import path from 'path';
import { fileURLToPath } from 'url';
import * as fs from 'fs/promises';
const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);
const rootPath = path.normalize(__dirname.split("src")[0]);

// Create a web server
const app = express();

// Serve all the files in the dist folder
app.use(express.static('dist'));


app.get("/hej",(req,res)=> res.send("HALLi hallo"));

// Always serve index.html if nothing else found
app.get('*', (req, res) => {
  res.sendFile(path.join(__dirname, 'dist', 'index.html'));
});

// Start the web server on a port
app.listen(port, () => console.log('Listening on port ' + port));
