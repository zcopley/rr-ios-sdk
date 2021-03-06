//
//  Copyright (c) 2016 Rich Relevance Inc. All rights reserved.
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//    http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.

#import "RCHPlacementRecsViewController.h"
#import <RichRelevanceSDK/RichRelevanceSDK.h>
#import "SVProgressHUD.h"
#import "UIViewController+RCHExtensions.h"

@interface RCHPlacementRecsViewController ()

@end

@implementation RCHPlacementRecsViewController

- (void)loadData
{
    // Create a "recsForPlacements" builder for the "add to cart" placement type.

    RCHRequestPlacement *placement = [[RCHRequestPlacement alloc] initWithPageType:RCHPlacementPageTypeAddToCart name:@"prod1"];
    RCHPlacementRecsBuilder *builder = [RCHSDK builderForRecsWithPlacement:placement];

    // Execute the request, process the results, and track a view of the first product returned.

    [SVProgressHUD show];

    [[RCHSDK defaultClient] sendRequest:[builder build] success:^(id responseObject) {

        RCHPlacementsResult *result = responseObject;
        RCHRecommendedPlacement *placement = result.placements[0];

        self.products = placement.recommendedProducts;
        [self.tableView reloadData];

        [SVProgressHUD dismiss];
    } failure:^(id responseObject, NSError *error) {
        [SVProgressHUD dismiss];
        [self rch_showAlertForError:error];
    }];
}

@end
