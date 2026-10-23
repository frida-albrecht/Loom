module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func private @printMemrefI64(tensor<*xi64>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<false> : tensor<4x10x1x1xi1>}> : () -> tensor<4x10x1x1xi1>
    %1 = "tosa.const"() <{values = dense<-182> : tensor<9x3x8x1xi64>}> : () -> tensor<9x3x8x1xi64>
    %2 = "tosa.const"() <{values = dense<-119> : tensor<9x1x1x1xi64>}> : () -> tensor<9x1x1x1xi64>
    %3 = "tosa.const"() <{values = dense<-5.304000e+01> : tensor<8x6x3x2xf32>}> : () -> tensor<8x6x3x2xf32>
    %4 = tosa.reduce_any %0 {axis = 2 : i32} : (tensor<4x10x1x1xi1>) -> tensor<4x10x1x1xi1>
    %5 = tosa.minimum %1, %2 : (tensor<9x3x8x1xi64>, tensor<9x1x1x1xi64>) -> tensor<9x3x8x1xi64>
    %6 = tosa.log %3 : (tensor<8x6x3x2xf32>) -> tensor<8x6x3x2xf32>
    %7 = tosa.argmax %4 {axis = 3 : i32} : (tensor<4x10x1x1xi1>) -> tensor<4x10x1xi32>
    %8 = tosa.identity %6 : (tensor<8x6x3x2xf32>) -> tensor<8x6x3x2xf32>
    %9 = tosa.clz %7 : (tensor<4x10x1xi32>) -> tensor<4x10x1xi32>
    %10 = tosa.logical_right_shift %9, %7 : (tensor<4x10x1xi32>, tensor<4x10x1xi32>) -> tensor<4x10x1xi32>
    %cast = tensor.cast %5 : tensor<9x3x8x1xi64> to tensor<*xi64>
    %cast_0 = tensor.cast %8 : tensor<8x6x3x2xf32> to tensor<*xf32>
    %cast_1 = tensor.cast %10 : tensor<4x10x1xi32> to tensor<*xi32>
    call @printMemrefI64(%cast) : (tensor<*xi64>) -> ()
    call @printMemrefF32(%cast_0) : (tensor<*xf32>) -> ()
    call @printMemrefI32(%cast_1) : (tensor<*xi32>) -> ()
    return
  }
}

