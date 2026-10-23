module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<80> : tensor<9x5x3xi32>}> : () -> tensor<9x5x3xi32>
    %1 = "tosa.const"() <{values = dense<-174> : tensor<9x3x10xi32>}> : () -> tensor<9x3x10xi32>
    %2 = "tosa.const"() <{values = dense<-5.437000e+01> : tensor<1x3x1xf32>}> : () -> tensor<1x3x1xf32>
    %3 = "tosa.const"() <{values = dense<0> : tensor<1xi32>}> : () -> tensor<1xi32>
    %4 = "tosa.const"() <{values = dense<0> : tensor<1xi32>}> : () -> tensor<1xi32>
    %5 = tosa.matmul %0, %1, %3, %4 : (tensor<9x5x3xi32>, tensor<9x3x10xi32>, tensor<1xi32>, tensor<1xi32>) -> tensor<9x5x10xi32>
    %6 = tosa.reduce_min %5 {axis = 1 : i32} : (tensor<9x5x10xi32>) -> tensor<9x1x10xi32>
    %7 = tosa.argmax %6 {axis = 0 : i32} : (tensor<9x1x10xi32>) -> tensor<1x10xi32>
    %8 = tosa.sub %7, %7 : (tensor<1x10xi32>, tensor<1x10xi32>) -> tensor<1x10xi32>
    %9 = tosa.bitwise_xor %8, %8 : (tensor<1x10xi32>, tensor<1x10xi32>) -> tensor<1x10xi32>
    %10 = tosa.const_shape  {values = dense<[2, 3]> : tensor<2xindex>} : () -> !tosa.shape<2>
    %11 = tosa.tile %9, %10 : (tensor<1x10xi32>, !tosa.shape<2>) -> tensor<2x30xi32>
    %12 = tosa.exp %2 : (tensor<1x3x1xf32>) -> tensor<1x3x1xf32>
    %cast = tensor.cast %11 : tensor<2x30xi32> to tensor<*xi32>
    %cast_0 = tensor.cast %12 : tensor<1x3x1xf32> to tensor<*xf32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    call @printMemrefF32(%cast_0) : (tensor<*xf32>) -> ()
    return
  }
}

