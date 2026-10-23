module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<1.312000e+01> : tensor<7x123x124xf32>}> : () -> tensor<7x123x124xf32>
    %1 = "tosa.const"() <{values = dense<-1.367900e+02> : tensor<8x128x128xf32>}> : () -> tensor<8x128x128xf32>
    %c6 = arith.constant 6 : index
    %cst = arith.constant 0.000000e+00 : f32
    %c0 = arith.constant 0 : index
    %padded = tensor.pad %0 low[1, 2, 0] high[0, 3, 4] {
    ^bb0(%arg0: index, %arg1: index, %arg2: index):
      tensor.yield %cst : f32
    } : tensor<7x123x124xf32> to tensor<8x128x128xf32>
    %2 = tensor.empty() : tensor<8x384x384xf32>
    %3 = linalg.fill ins(%cst : f32) outs(%2 : tensor<8x384x384xf32>) -> tensor<8x384x384xf32>
    %inserted_slice = tensor.insert_slice %1 into %3[0, 0, %c6] [8, 128, 128] [1, 1, 1] : tensor<8x128x128xf32> into tensor<8x384x384xf32>
    %inserted_slice_0 = tensor.insert_slice %1 into %inserted_slice[0, 128, 255] [8, 128, 128] [1, 1, 1] : tensor<8x128x128xf32> into tensor<8x384x384xf32>
    %inserted_slice_1 = tensor.insert_slice %padded into %inserted_slice_0[0, 0, 256] [8, 128, 128] [1, 1, 1] : tensor<8x128x128xf32> into tensor<8x384x384xf32>
    %cast = tensor.cast %inserted_slice_1 : tensor<8x384x384xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}

