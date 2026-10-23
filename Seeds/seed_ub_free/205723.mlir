module {
  func.func private @printMemrefI8(tensor<*xi8>) attributes {llvm.emit_c_interface}
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-2.912000e+01> : tensor<10x5x4xf32>}> : () -> tensor<10x5x4xf32>
    %1 = "tosa.const"() <{values = dense<-1.535900e+02> : tensor<10x4x10xf32>}> : () -> tensor<10x4x10xf32>
    %2 = "tosa.const"() <{values = dense<-3> : tensor<i8>}> : () -> tensor<i8>
    %3 = "tosa.const"() <{values = dense<0.000000e+00> : tensor<1xf32>}> : () -> tensor<1xf32>
    %4 = "tosa.const"() <{values = dense<0.000000e+00> : tensor<1xf32>}> : () -> tensor<1xf32>
    %5 = tosa.matmul %0, %1, %3, %4 : (tensor<10x5x4xf32>, tensor<10x4x10xf32>, tensor<1xf32>, tensor<1xf32>) -> tensor<10x5x10xf32>
    %6 = tosa.log %5 : (tensor<10x5x10xf32>) -> tensor<10x5x10xf32>
    %7 = tosa.bitwise_not %2 : (tensor<i8>) -> tensor<i8>
    %8 = tosa.reduce_sum %6 {axis = 1 : i32} : (tensor<10x5x10xf32>) -> tensor<10x1x10xf32>
    %9 = tosa.add %8, %8 : (tensor<10x1x10xf32>, tensor<10x1x10xf32>) -> tensor<10x1x10xf32>
    %cast = tensor.cast %7 : tensor<i8> to tensor<*xi8>
    %cast_0 = tensor.cast %9 : tensor<10x1x10xf32> to tensor<*xf32>
    call @printMemrefI8(%cast) : (tensor<*xi8>) -> ()
    call @printMemrefF32(%cast_0) : (tensor<*xf32>) -> ()
    return
  }
}

