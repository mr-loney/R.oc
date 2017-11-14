//
//  ViewController.m
//  R-OC-Simple
//
//  Created by jun peng on 2017/7/6.
//  Copyright © 2017年 R-OC. All rights reserved.
//

#import "ViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    AVSpeechSynthesizer *avSpeech = [[AVSpeechSynthesizer alloc]init];
    AVSpeechUtterance *avSpeechterance = [AVSpeechUtterance speechUtteranceWithString:@"这里是R-OC"];
    AVSpeechSynthesisVoice *voiceType = [AVSpeechSynthesisVoice voiceWithLanguage:@"zh-CN"];
    avSpeechterance.voice = voiceType;
    avSpeechterance.rate *= 1;
    [avSpeech speakUtterance:avSpeechterance];
    
    UIImageView *img = [UIImageView new];
    img.frame = CGRectMake(100, 100, 100, 100);
    img.image = R.image.tab_me_on;
    img.image = R.image.tab_me_off;
    [self.view addSubview:img];
    
    NSString *h = R.file.HijackReport;
    NSString *h_p = R.file.HijackReport_path;
    NSString *f = R.file.a739c8abf_e1dc_4655_9fc9_55788eeca0dd;
    UIView *v = R.xib.xxx;
    UIStoryboard *ss = R.storyboard.sss;
    UIImage *a = R.bundle.testBundle.image.a16844981_4C69_4A9E_B706_14AE9063C317;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
