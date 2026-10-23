module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-5> : tensor<1x5x3x32x32xi8>}> : () -> tensor<1x5x3x32x32xi8>
    %1 = "tosa.const"() <{values = dense<6> : tensor<5x2x3x3x3xi8>}> : () -> tensor<5x2x3x3x3xi8>
    %c200_i32 = arith.constant 200 : i32
    %c141_i32 = arith.constant 141 : i32
    %2 = "tosa.const"() <{values = dense<138> : tensor<1x5x2x30x30xi32>}> : () -> tensor<1x5x2x30x30xi32>
    %3 = linalg.conv_2d_ngchw_gfchw_q {dilations = dense<1> : tensor<2xi64>, strides = dense<1> : tensor<2xi64>} ins(%0, %1, %c200_i32, %c141_i32 : tensor<1x5x3x32x32xi8>, tensor<5x2x3x3x3xi8>, i32, i32) outs(%2 : tensor<1x5x2x30x30xi32>) -> tensor<1x5x2x30x30xi32>
    %cast = tensor.cast %3 : tensor<1x5x2x30x30xi32> to tensor<*xi32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    return
  }
}

