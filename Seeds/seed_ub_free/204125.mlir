module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func private @printMemrefI64(tensor<*xi64>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<102> : tensor<6x9xi64>}> : () -> tensor<6x9xi64>
    %1 = "tosa.const"() <{values = dense<-101> : tensor<6xi32>}> : () -> tensor<6xi32>
    %2 = "tosa.const"() <{values = dense<76> : tensor<1xi32>}> : () -> tensor<1xi32>
    %3 = "tosa.const"() <{values = dense<-1.360900e+02> : tensor<10x1xf32>}> : () -> tensor<10x1xf32>
    %4 = tosa.const_shape  {values = dense<[1, 54]> : tensor<2xindex>} : () -> !tosa.shape<2>
    %5 = tosa.reshape %0, %4 : (tensor<6x9xi64>, !tosa.shape<2>) -> tensor<1x54xi64>
    %6 = tosa.intdiv %1, %2 : (tensor<6xi32>, tensor<1xi32>) -> tensor<6xi32>
    %7 = tosa.rsqrt %3 : (tensor<10x1xf32>) -> tensor<10x1xf32>
    %cast = tensor.cast %5 : tensor<1x54xi64> to tensor<*xi64>
    %cast_0 = tensor.cast %6 : tensor<6xi32> to tensor<*xi32>
    %cast_1 = tensor.cast %7 : tensor<10x1xf32> to tensor<*xf32>
    call @printMemrefI64(%cast) : (tensor<*xi64>) -> ()
    call @printMemrefI32(%cast_0) : (tensor<*xi32>) -> ()
    call @printMemrefF32(%cast_1) : (tensor<*xf32>) -> ()
    return
  }
}

