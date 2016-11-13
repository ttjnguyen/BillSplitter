//
//  ViewController.m
//  BillSplitter
//
//  Created by Jenny Nguyen on 2016-11-13.
//  Copyright © 2016 LightHouseLabs. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *amountToPayTextField;
@property (weak, nonatomic) IBOutlet UILabel *amountToPayPerPersonLabel;
@property (weak, nonatomic) IBOutlet UISlider *numberOfPeopleSlider;



@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.amountToPayTextField.delegate = self;
}
- (IBAction)updateFromSlider:(id)sender {
    
    self.amountToPayPerPersonLabel.text = [self formatResultFromTotal:self.amountToPayTextField.text
                                                            andPeople:self.numberOfPeopleSlider.value];
    }

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSString *updatedString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    
    
    if(![updatedString isEqualToString:@""])
        self.amountToPayPerPersonLabel.text = [self formatResultFromTotal:updatedString
                                                                andPeople:self.numberOfPeopleSlider.value];
    
    return YES;
}

- (NSString*)formatResultFromTotal:(NSString*)amountToPay andPeople:(int)numberOfPeople
{
    
    NSDecimalNumber *number = [NSDecimalNumber decimalNumberWithString:amountToPay];
    NSDecimalNumber *number2 = (NSDecimalNumber*)[NSDecimalNumber numberWithInteger:numberOfPeople];
    NSDecimalNumber *number3= [number decimalNumberByDividingBy:number2];
    
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter stringFromNumber:number3];
    [formatter setNumberStyle:NSNumberFormatterCurrencyStyle];
    [formatter stringFromNumber:number3];
    
    return [formatter stringFromNumber:number3];
}

- (IBAction)calculateSplitAmount:(id)sender {
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    
    NSDecimalNumber* number = [NSDecimalNumber decimalNumberWithString:(self.amountToPayTextField.text)];
    NSDecimalNumber *number2 = (NSDecimalNumber*)[NSDecimalNumber numberWithFloat:(self.numberOfPeopleSlider.value)];
    NSDecimalNumber *number3= [number decimalNumberByDividingBy:number2];
    
    [formatter stringFromNumber:number3];
    [formatter setNumberStyle:NSNumberFormatterCurrencyStyle];
    self.amountToPayPerPersonLabel.text = [formatter stringFromNumber:number3];
}
@end
