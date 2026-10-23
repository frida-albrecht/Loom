module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<55> : tensor<10x6x5xi32>}> : () -> tensor<10x6x5xi32>
    %1 = "tosa.const"() <{values = dense<-39> : tensor<1x6x5xi32>}> : () -> tensor<1x6x5xi32>
    %2 = "tosa.const"() <{values = dense<-1.539200e+02> : tensor<9x8x8x2xf32>}> : () -> tensor<9x8x8x2xf32>
    %3 = tosa.maximum %0, %1 : (tensor<10x6x5xi32>, tensor<1x6x5xi32>) -> tensor<10x6x5xi32>
    %4 = tosa.reduce_product %3 {axis = 1 : i32} : (tensor<10x6x5xi32>) -> tensor<10x1x5xi32>
    %5 = tosa.maximum %4, %4 : (tensor<10x1x5xi32>, tensor<10x1x5xi32>) -> tensor<10x1x5xi32>
    %6 = tosa.sigmoid %2 : (tensor<9x8x8x2xf32>) -> tensor<9x8x8x2xf32>
    %7 = tosa.argmax %5 {axis = 1 : i32} : (tensor<10x1x5xi32>) -> tensor<10x5xi32>
    %8 = tosa.argmax %6 {axis = 2 : i32} : (tensor<9x8x8x2xf32>) -> tensor<9x8x2xi32>
    %9 = tosa.reduce_max %8 {axis = 1 : i32} : (tensor<9x8x2xi32>) -> tensor<9x1x2xi32>
    %10 = tosa.rsqrt %6 : (tensor<9x8x8x2xf32>) -> tensor<9x8x8x2xf32>
    %cast = tensor.cast %7 : tensor<10x5xi32> to tensor<*xi32>
    %cast_0 = tensor.cast %9 : tensor<9x1x2xi32> to tensor<*xi32>
    %cast_1 = tensor.cast %10 : tensor<9x8x8x2xf32> to tensor<*xf32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    call @printMemrefI32(%cast_0) : (tensor<*xi32>) -> ()
    call @printMemrefF32(%cast_1) : (tensor<*xf32>) -> ()
    return
  }
}

