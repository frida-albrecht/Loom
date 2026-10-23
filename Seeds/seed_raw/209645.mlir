module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-4.976000e+01> : tensor<3xf32>}> : () -> tensor<3xf32>
    %1 = "tosa.const"() <{values = dense<-25> : tensor<i32>}> : () -> tensor<i32>
    %2 = "tosa.const"() <{values = dense<92> : tensor<i32>}> : () -> tensor<i32>
    %3 = tosa.exp %0 : (tensor<3xf32>) -> tensor<3xf32>
    %4 = tosa.intdiv %1, %2 : (tensor<i32>, tensor<i32>) -> tensor<i32>
    %5 = tosa.intdiv %4, %4 : (tensor<i32>, tensor<i32>) -> tensor<i32>
    %6 = tosa.const_shape  {values = dense<1> : tensor<3xindex>} : () -> !tosa.shape<3>
    %7 = tosa.reshape %5, %6 : (tensor<i32>, !tosa.shape<3>) -> tensor<1x1x1xi32>
    %8 = tosa.maximum %7, %7 : (tensor<1x1x1xi32>, tensor<1x1x1xi32>) -> tensor<1x1x1xi32>
    %9 = tosa.tanh %3 : (tensor<3xf32>) -> tensor<3xf32>
    %10 = tosa.add %4, %4 : (tensor<i32>, tensor<i32>) -> tensor<i32>
    %11 = tosa.sigmoid %3 : (tensor<3xf32>) -> tensor<3xf32>
    %cast = tensor.cast %8 : tensor<1x1x1xi32> to tensor<*xi32>
    %cast_0 = tensor.cast %9 : tensor<3xf32> to tensor<*xf32>
    %cast_1 = tensor.cast %10 : tensor<i32> to tensor<*xi32>
    %cast_2 = tensor.cast %11 : tensor<3xf32> to tensor<*xf32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    call @printMemrefF32(%cast_0) : (tensor<*xf32>) -> ()
    call @printMemrefI32(%cast_1) : (tensor<*xi32>) -> ()
    call @printMemrefF32(%cast_2) : (tensor<*xf32>) -> ()
    return
  }
}

