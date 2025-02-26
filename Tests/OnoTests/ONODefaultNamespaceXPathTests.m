// ONODefaultNamespaceXPathTests.m
//
// Copyright (c) 2014 – 2018 Mattt (https://mat.tt)
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import <XCTest/XCTest.h>

#import "Ono.h"
#import "ONOXMLDocument.h"

@interface ONODefaultNamespaceXPathTests : XCTestCase
@property (nonatomic, strong) ONOXMLDocument *document;
@end

@implementation ONODefaultNamespaceXPathTests

- (void)setUp {
    [super setUp];

    NSError *error = nil;
    
    /*
     I've tried everything, but I can't get access to the ocf.xml file in the bundle...
     So... for now, just embedding the XML data here.  Yeah.  I know.  Sorry.
     */
//    NSBundle *bundle = [NSBundle bundleForClass:[self class]];
//    NSURL *url = [bundle URLForResource:@"ocf" withExtension:@"txt"];
//    if (url != nil) {
//        NSLog(url.description);
//    }
//
//    NSString *pathTest = [SWIFTPM_MODULE_BUNDLE pathForResource:@"ocf" ofType:@"xml"];
//    NSURL *urlTest = [SWIFTPM_MODULE_BUNDLE URLForResource:@"ocf" withExtension:@"xml"];
    
    NSString *filePath = [SWIFTPM_MODULE_BUNDLE pathForResource:@"ocf" ofType:@"xml"];
    NSData *xmlData = [NSData dataWithContentsOfFile:filePath];


//    NSString *xmlDataString = \
//    @"<?xml version=\"1.0\" encoding=\"utf-8\" standalone=\"no\"?>" \
//    @"<container xmlns=\"urn:oasis:names:tc:opendocument:xmlns:container\" version=\"1.0\">" \
//    @"  <rootfiles>" \
//    @"    <rootfile full-path=\"OEBPS/content.opf\" media-type=\"application/oebps-package+xml\"/>" \
//    @"  </rootfiles>" \
//    @"</container>";
    
    //NSData *xmlData = [xmlDataString dataUsingEncoding: NSUTF8StringEncoding];
    self.document = [ONOXMLDocument XMLDocumentWithData:xmlData error:&error];
    
    XCTAssertNotNil(self.document, @"Document should not be nil");
    XCTAssertNil(error, @"Error should not be generated");
}

#pragma mark -

- (void)testAbsoluteXPathWithDefaultNamespace {
    [self.document definePrefix:@"ocf" forDefaultNamespace:@"urn:oasis:names:tc:opendocument:xmlns:container"];
    NSString *XPath = @"/ocf:container/ocf:rootfiles/ocf:rootfile";
    NSUInteger count = 0;
    for (ONOXMLElement *element in [self.document XPath:XPath]) {
        XCTAssertEqualObjects(@"rootfile", element.tag, @"tag should be `rootfile`");
        count++;
    }
    
    XCTAssertEqual(1, count, @"Element should be found at XPath '%@'", XPath);
}

- (void)testRelativeXPathWithDefaultNamespace {
    [self.document definePrefix:@"ocf" forDefaultNamespace:@"urn:oasis:names:tc:opendocument:xmlns:container"];
    NSString *absoluteXPath = @"/ocf:container/ocf:rootfiles";
    NSString *relativeXPath = @"./ocf:rootfile";
    NSUInteger count = 0;
    for (ONOXMLElement *absoluteElement in [self.document XPath:absoluteXPath]) {
        for (ONOXMLElement *relativeElement in [absoluteElement XPath:relativeXPath]) {
            XCTAssertEqualObjects(@"rootfile", relativeElement.tag, @"tag should be `rootfile`");
            count++;
        }
    }
    
    XCTAssertEqual(1, count, @"Element should be found at XPath '%@' relative to XPath '%@'", relativeXPath, absoluteXPath);
}

@end

