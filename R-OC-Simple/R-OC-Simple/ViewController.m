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
    [self.view addSubview:img];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
