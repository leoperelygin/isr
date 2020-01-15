package org.example.RushGarage.controller;

import org.example.RushGarage.domain.Message;
import org.example.RushGarage.domain.User;
import org.example.RushGarage.repos.MessageRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.util.Map;
import java.util.UUID;

@Controller
public class MainController {
    @Autowired
    private MessageRepo messageRepo;

    @Value("${upload.path}")
    private String uploadPath;

    @GetMapping("/")
    public String greeting(Map<String, Object> model) {
        return "greeting";
    }

    @GetMapping("/main")
    public String main(@RequestParam(required = false, defaultValue = "") String filter, Model model){
        Iterable<Message> messages;

        if (filter != null && !filter.isEmpty()) {
            messages = messageRepo.findByTag(filter);
        }
        else {
            messages = messageRepo.findAll();
        }

        model.addAttribute("messages", messages);
        model.addAttribute("filter", filter);
        return "main";
    }

    @PostMapping("/main")
    public String add (
            @AuthenticationPrincipal User user,
            @RequestParam String text,
            @RequestParam String tag, Map<String, Object> model
    ) throws IOException {
        Message message =new Message(text, tag, user);



        messageRepo.save(message);

        Iterable<Message> messages = messageRepo.findAll();
        model.put("messages", messages);

        return "main";
    }

    @GetMapping("delete/{message}")
    public String messageDelete(@PathVariable Message message, Model model) {
        model.addAttribute("message", message);

        messageRepo.deleteById(message.getId());

        return "redirect:/main";
    }

    @GetMapping("edit/{message}")
    public String messageEdit(@PathVariable Message message, Model model) {
        model.addAttribute("message", message);

        return "messageEdit";
    }

    @PostMapping("/save")
    public String messageSave(
            @RequestParam String text,
            @RequestParam String tag,
            @RequestParam Map<String, String> form,
            @RequestParam("messageId") Message message)
    {
        message.setText(text);
        message.setTag(tag);


        messageRepo.save(message);

        return "redirect:/main";
    }

}