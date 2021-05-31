%% plot confusion matrix
clear;
        dataTitle  = {'wine','thyroid', 'iris', 'glass','engine','cancer','abalone'};
        funcnames = {'linear','Sigmoid','Tanh','RELU','ELU','SELU','Softplus'};
        funcpt = {@linear,@Sigmoid,@Tanh,@RELU,@ELU,@SELU,@Softplus};
        
        
for        datasel = [1,3,6]%;%3;%6;
        load([dataTitle{datasel},'data']);
        
%%
        
        for f = 1:length(funcnames)
        filename = [funcnames{f},'_',dataTitle{datasel},'wb'];
        load(filename);
        func = funcpt{f};
        
        
        [a1,a2,a3,a4,a5] = fwdpass(func,w1,b1,w2,b2,w3,b3,w4,b4,w5,b5,x);
        
        [c,cm,ind,per] = confusion(y,a5);
        figure; plotconfusion(y,a5); title(funcnames{f});
        print(gcf, '-dpng', [dataTitle{datasel},'Train',funcnames{f},'.png']);
        saveas(gcf, [dataTitle{datasel},'Train',funcnames{f},'.png']);
        end
 
        %%
        for f = 1:length(funcnames)
        filename = [funcnames{f},'_',dataTitle{datasel},'wb'];
        load(filename);
        func = funcpt{f};
        
        
        [a1,a2,a3,a4,a5] = fwdpass(func,w1,b1,w2,b2,w3,b3,w4,b4,w5,b5,x_val);
        
        [c,cm,ind,per] = confusion(y_val,a5);
        figure; plotconfusion(y_val,a5); title(funcnames{f});
        print(gcf, '-dpng', [dataTitle{datasel},'Validation',funcnames{f},'.png']);
        saveas(gcf, [dataTitle{datasel},'Validation',funcnames{f},'.png']);
        end 
  %%      
        for f = 1:length(funcnames)
        filename = [funcnames{f},'_',dataTitle{datasel},'wb'];
        load(filename);
        func = funcpt{f};
        
        
        [a1,a2,a3,a4,a5] = fwdpass(func,w1,b1,w2,b2,w3,b3,w4,b4,w5,b5,x_test);
        
        [c,cm,ind,per] = confusion(y_test,a5);
        figure; plotconfusion(y_test,a5); title(funcnames{f});
        print(gcf, '-dpng', [dataTitle{datasel},'Test',funcnames{f},'.png']);
        saveas(gcf, [dataTitle{datasel},'Test',funcnames{f},'.png']);
        
        end      
        
end