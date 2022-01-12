package com.koreait.nearby.controller;

import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.servlet.NoHandlerFoundException;

@ControllerAdvice
@Controller
public class ErrorController {

	
	 
	 @ExceptionHandler(Exception.class)
	 public String except(Exception e, Model model){ 
		 model.addAttribute("exception", e);
		 return "error/500error";
	 }
	
	
	 @ExceptionHandler(NoHandlerFoundException.class)
	 @ResponseStatus(value = HttpStatus.NOT_FOUND)
     public String handle404(NoHandlerFoundException ex) { 
		 return "error/404error"; 
		 }
	
	
}
