package br.com.bcp;

import java.time.LocalTime;
import java.util.Random;
import java.util.concurrent.TimeUnit;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class Controller {

    private static Logger LOG = LoggerFactory.getLogger(Controller.class);

    @GetMapping("/")
    public String sayHello(@RequestParam(value = "name", defaultValue = "Guest") String name) {
        LOG.info("Method sayHello with value {}", name);
        return "Hello " + name + "!!" + LocalTime.now();
    }


    @GetMapping("/log")
    public String doLog() {
        LOG.trace("A TRACE Message");
        LOG.debug("A DEBUG Message");
        LOG.info("An INFO Message");
        LOG.warn("A WARN Message");
        LOG.error("An ERROR Message");
        return "Logged " + LocalTime.now();
    }
    

    @GetMapping("/slowApi")
    public String timeConsumingAPI(@RequestParam(value = "delay", defaultValue = "0") Integer delay) throws InterruptedException {
        LOG.info("Method timeConsumingAPI with value {}", delay);
        if(delay == 0) {
            Random random = new Random();
            delay = random.nextInt(10);
        }

        TimeUnit.SECONDS.sleep(delay);
        return "Ok " + LocalTime.now();
    }

    @GetMapping("/cpuLoad")
    public String cpuLoad(@RequestParam(value = "loop", defaultValue = "1000") Integer loop)  {
        LOG.info("Method cpuLoad with value {}", loop);
        for (int i = 0; i < loop; i++) {
            for (int j = 0; j < loop; j++) {
                Math.atan(Math.sqrt(Math.pow(9, 10)));
            }
        }
        return "Done " + LocalTime.now();
    }

    @GetMapping("/throwError")
    public String throwError()  {
        try {
            int value = 10 / 0;
            LOG.info("Will never log this, result 10/0 =  {}", value);
        } catch (Exception e) {
            LOG.error("Ops :-( something went wrong", e);
        }
        return "Finished " + LocalTime.now();
    }
}
