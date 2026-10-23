module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<75> : tensor<3x2x5xi32>}> : () -> tensor<3x2x5xi32>
    %1 = "tosa.const"() <{values = dense<-9> : tensor<3x5x4xi32>}> : () -> tensor<3x5x4xi32>
    %2 = "tosa.const"() <{values = dense<-1.889100e+02> : tensor<1xf32>}> : () -> tensor<1xf32>
    %3 = "tosa.const"() <{values = dense<0> : tensor<1xi32>}> : () -> tensor<1xi32>
    %4 = "tosa.const"() <{values = dense<0> : tensor<1xi32>}> : () -> tensor<1xi32>
    %5 = tosa.matmul %0, %1, %3, %4 : (tensor<3x2x5xi32>, tensor<3x5x4xi32>, tensor<1xi32>, tensor<1xi32>) -> tensor<3x2x4xi32>
    %6 = tosa.ceil %2 : (tensor<1xf32>) -> tensor<1xf32>
    %7 = tosa.sub %5, %5 : (tensor<3x2x4xi32>, tensor<3x2x4xi32>) -> tensor<3x2x4xi32>
    %8 = tosa.const_shape  {values = dense<1> : tensor<1xindex>} : () -> !tosa.shape<1>
    %9 = tosa.tile %6, %8 : (tensor<1xf32>, !tosa.shape<1>) -> tensor<1xf32>
    %10 = tosa.reverse %7 {axis = 2 : i32} : (tensor<3x2x4xi32>) -> tensor<3x2x4xi32>
    %cast = tensor.cast %9 : tensor<1xf32> to tensor<*xf32>
    %cast_0 = tensor.cast %10 : tensor<3x2x4xi32> to tensor<*xi32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    call @printMemrefI32(%cast_0) : (tensor<*xi32>) -> ()
    return
  }
}

