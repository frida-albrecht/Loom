module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<82.8899993> : tensor<5x2xf32>}> : () -> tensor<5x2xf32>
    %1 = "tosa.const"() <{values = dense<-1.847000e+01> : tensor<5x2xf32>}> : () -> tensor<5x2xf32>
    %2 = tosa.minimum %0, %1 : (tensor<5x2xf32>, tensor<5x2xf32>) -> tensor<5x2xf32>
    %3 = tosa.const_shape  {values = dense<10> : tensor<1xindex>} : () -> !tosa.shape<1>
    %4 = tosa.reshape %2, %3 : (tensor<5x2xf32>, !tosa.shape<1>) -> tensor<10xf32>
    %5 = tosa.reverse %4 {axis = 0 : i32} : (tensor<10xf32>) -> tensor<10xf32>
    %6 = tosa.rsqrt %5 : (tensor<10xf32>) -> tensor<10xf32>
    %7 = tosa.rsqrt %6 : (tensor<10xf32>) -> tensor<10xf32>
    %8 = tosa.argmax %7 {axis = 0 : i32} : (tensor<10xf32>) -> tensor<i32>
    %9 = tosa.const_shape  {values = dense<2> : tensor<1xindex>} : () -> !tosa.shape<1>
    %10 = tosa.tile %6, %9 : (tensor<10xf32>, !tosa.shape<1>) -> tensor<20xf32>
    %11 = tosa.logical_left_shift %8, %8 : (tensor<i32>, tensor<i32>) -> tensor<i32>
    %12 = tosa.reciprocal %10 : (tensor<20xf32>) -> tensor<20xf32>
    %c1 = "tosa.const"() <{values = dense<1> : tensor<i32>}> : () -> tensor<i32>
    %s0 = tosa.maximum %8, %c1 : (tensor<i32>, tensor<i32>) -> tensor<i32>
    %13 = tosa.intdiv %11, %s0 : (tensor<i32>, tensor<i32>) -> tensor<i32>
    %14 = tosa.exp %5 : (tensor<10xf32>) -> tensor<10xf32>
    %15 = tosa.floor %4 : (tensor<10xf32>) -> tensor<10xf32>
    %16 = tosa.const_shape  {values = dense<1> : tensor<4xindex>} : () -> !tosa.shape<4>
    %17 = tosa.reshape %13, %16 : (tensor<i32>, !tosa.shape<4>) -> tensor<1x1x1x1xi32>
    %cast = tensor.cast %12 : tensor<20xf32> to tensor<*xf32>
    %cast_0 = tensor.cast %14 : tensor<10xf32> to tensor<*xf32>
    %cast_1 = tensor.cast %15 : tensor<10xf32> to tensor<*xf32>
    %cast_2 = tensor.cast %17 : tensor<1x1x1x1xi32> to tensor<*xi32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    call @printMemrefF32(%cast_0) : (tensor<*xf32>) -> ()
    call @printMemrefF32(%cast_1) : (tensor<*xf32>) -> ()
    call @printMemrefI32(%cast_2) : (tensor<*xi32>) -> ()
    return
  }
}