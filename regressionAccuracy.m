%% continourse output result compare

clear;
        dataTitle  = {'wine','thyroid', 'iris', 'glass','engine','cancer','abalone'};
        funcnames = {'linear','Sigmoid','Tanh','RELU','ELU','SELU','Softplus'};
        funcpt = {@linear,@Sigmoid,@Tanh,@RELU,@ELU,@SELU,@Softplus};
        
        
for        datasel = [5,7]
        load([dataTitle{datasel},'data']);
        
%%
        
        for f = 1:length(funcnames)
        filename = [funcnames{f},'_',dataTitle{datasel},'wb'];
        load(filename);
        func = funcpt{f};
        
        
        [a1,a2,a3,a4,a5] = fwdpass(func,w1,b1,w2,b2,w3,b3,w4,b4,w5,b5,x);
        

        figure; 
        scatter3(x(1,:),x(1,:),y(1,:));  hold on;
        scatter3(x(1,:),x(1,:),a5(1,:)); 
        title(funcnames{f});
%         print(gcf, '-dpng', [dataTitle{datasel},'Train',funcnames{f},'.png']);
%         saveas(gcf, [dataTitle{datasel},'Train',funcnames{f},'.png']);
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