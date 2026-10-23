module {
  func.func private @printMemrefI16(tensor<*xi16>) attributes {llvm.emit_c_interface}
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-9.487000e+01> : tensor<4x8x10xf32>}> : () -> tensor<4x8x10xf32>
    %1 = "tosa.const"() <{values = dense<-1.228400e+02> : tensor<4x10x6xf32>}> : () -> tensor<4x10x6xf32>
    %2 = "tosa.const"() <{values = dense<-197> : tensor<10x3x1xi16>}> : () -> tensor<10x3x1xi16>
    %3 = "tosa.const"() <{values = dense<0.000000e+00> : tensor<1xf32>}> : () -> tensor<1xf32>
    %4 = "tosa.const"() <{values = dense<0.000000e+00> : tensor<1xf32>}> : () -> tensor<1xf32>
    %5 = tosa.matmul %0, %1, %3, %4 : (tensor<4x8x10xf32>, tensor<4x10x6xf32>, tensor<1xf32>, tensor<1xf32>) -> tensor<4x8x6xf32>
    %6 = tosa.clz %2 : (tensor<10x3x1xi16>) -> tensor<10x3x1xi16>
    %cast = tensor.cast %5 : tensor<4x8x6xf32> to tensor<*xf32>
    %cast_0 = tensor.cast %6 : tensor<10x3x1xi16> to tensor<*xi16>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    call @printMemrefI16(%cast_0) : (tensor<*xi16>) -> ()
    return
  }
}

