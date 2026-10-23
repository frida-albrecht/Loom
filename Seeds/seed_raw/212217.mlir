module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<6.713000e+01> : tensor<8xf32>}> : () -> tensor<8xf32>
    %1 = "tosa.const"() <{values = dense<3.184000e+01> : tensor<1xf32>}> : () -> tensor<1xf32>
    %2 = tosa.add %0, %1 : (tensor<8xf32>, tensor<1xf32>) -> tensor<8xf32>
    %3 = tosa.const_shape  {values = dense<2> : tensor<3xindex>} : () -> !tosa.shape<3>
    %4 = tosa.reshape %2, %3 : (tensor<8xf32>, !tosa.shape<3>) -> tensor<2x2x2xf32>
    %5 = tosa.sigmoid %4 : (tensor<2x2x2xf32>) -> tensor<2x2x2xf32>
    %6 = tosa.concat %5, %4 {axis = 2 : i32} : (tensor<2x2x2xf32>, tensor<2x2x2xf32>) -> tensor<2x2x4xf32>
    %cast = tensor.cast %6 : tensor<2x2x4xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}

