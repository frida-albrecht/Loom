module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-1.529300e+02> : tensor<5x10xf32>}> : () -> tensor<5x10xf32>
    %1 = "tosa.const"() <{values = dense<49> : tensor<i32>}> : () -> tensor<i32>
    %2 = "tosa.const"() <{values = dense<-156> : tensor<i32>}> : () -> tensor<i32>
    %3 = tosa.reduce_max %0 {axis = 0 : i32} : (tensor<5x10xf32>) -> tensor<1x10xf32>
    %4 = tosa.ceil %3 : (tensor<1x10xf32>) -> tensor<1x10xf32>
    %5 = tosa.intdiv %1, %2 : (tensor<i32>, tensor<i32>) -> tensor<i32>
    %6 = tosa.clz %5 : (tensor<i32>) -> tensor<i32>
    %7 = tosa.reduce_max %3 {axis = 0 : i32} : (tensor<1x10xf32>) -> tensor<1x10xf32>
    %8 = tosa.pow %4, %4 : (tensor<1x10xf32>, tensor<1x10xf32>) -> tensor<1x10xf32>
    %9 = tosa.abs %5 : (tensor<i32>) -> tensor<i32>
    %10 = tosa.argmax %8 {axis = 0 : i32} : (tensor<1x10xf32>) -> tensor<10xi32>
    %11 = "tosa.const"() <{values = dense<0> : tensor<1xi32>}> : () -> tensor<1xi32>
    %12 = "tosa.const"() <{values = dense<0> : tensor<1xi32>}> : () -> tensor<1xi32>
    %13 = tosa.negate %9, %11, %12 : (tensor<i32>, tensor<1xi32>, tensor<1xi32>) -> tensor<i32>
    %14 = tosa.reduce_min %4 {axis = 1 : i32} : (tensor<1x10xf32>) -> tensor<1x1xf32>
    %15 = tosa.const_shape  {values = dense<1> : tensor<2xindex>} : () -> !tosa.shape<2>
    %16 = tosa.reshape %13, %15 : (tensor<i32>, !tosa.shape<2>) -> tensor<1x1xi32>
    %cast = tensor.cast %6 : tensor<i32> to tensor<*xi32>
    %cast_0 = tensor.cast %7 : tensor<1x10xf32> to tensor<*xf32>
    %cast_1 = tensor.cast %10 : tensor<10xi32> to tensor<*xi32>
    %cast_2 = tensor.cast %14 : tensor<1x1xf32> to tensor<*xf32>
    %cast_3 = tensor.cast %16 : tensor<1x1xi32> to tensor<*xi32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    call @printMemrefF32(%cast_0) : (tensor<*xf32>) -> ()
    call @printMemrefI32(%cast_1) : (tensor<*xi32>) -> ()
    call @printMemrefF32(%cast_2) : (tensor<*xf32>) -> ()
    call @printMemrefI32(%cast_3) : (tensor<*xi32>) -> ()
    return
  }
}

